# frozen_string_literal: true

module Smiten
  PaladinsEndpoint = 'https://api.paladins.com/paladinsapi.svc' # :nodoc:
  SmiteEndpoint    = 'https://api.smitegame.com/smiteapi.svc' # :nodoc:
  # At what interval do we need to refresh the session_id
  FifteenMins = (15 * 60 * 60) - 10
  # The responses are always encoded using JSON
  ResponseFormat = 'Json'
  Portal = { hi_rez: 1, steam: 5, ps4: 9, xbox: 10, switch: 22, discord: 25, epic: 28 }.freeze
  LanguageCode = { english: 1, german: 2, french: 3, chinese: 5, spanish: 7, spanish_latin_america: 9, portuguese: 10, russian: 11, polish: 12 }.freeze
  QueueCode = { live_siege: 424, conquest: 426, joust_ranked_1v1: 440, joust_ranked_3v3: 450, conquest_ranked: 451, live_competitive_gamepad: 428 }.freeze

  require_relative 'api'

  class Error < StandardError; end

  # The Core class implements those calls that are common to both the Smite and Paladins endpoints
  class Core < OpenStruct
    attr_reader :connector, :language_code, :calls
    attr_accessor :developerId, :authKey, :portal_id

    def build_apis # :nodoc:
      @calls.merge!(core_api).freeze
      calls.each_key do |api|
        next if self.class.method_defined?(api)

        self.class.define_method(api) do |args = {}|
          args.each_pair do |key, value|
            if key == :timeout
              @url.timeout = value
            else
              send("#{key}=", value)
            end
          end
          @url = calls[api][1].call
          payload = get
          { kind: calls[api][0], payload: payload }
        end
      end
    end

    # Creates a new connection to the Hirez API end points
    # It takes a single hash parameter which must contain the following two keys
    #
    #  :developerId
    #  :authKey
    #
    # These can be requested from the Hirez development team
    def initialize(options)
      # We default to talking to the paladins endpoint
      options.merge!(headers: { 'Content-Type' => 'application/json' })
      options.merge!(url: PaladinsEndpoint) unless options[:url]
      @developerId = options.delete(:developerId)
      @authKey = options.delete(:authKey)
      @language_code = LanguageCode[:english]
      @portal_id = nil
      @session_id = nil
      @connector = Faraday.new(options) do |f|
        f.request :json # encode req bodies as JSON
        f.request :retry # retry transient failures
        f.response :json # decode response bodies as JSON
      end
      @calls = {}
      build_apis
      super
    end

    def incept # :nodoc:
      @incept ||= Time.now
    end

    def timestamp # :nodoc:
      @timestamp ||= incept.getutc.strftime('%Y%m%d%H%M%S')
    end

    def signature(api_call) # :nodoc:
      Digest::MD5.hexdigest(developerId + api_call.to_s + authKey + timestamp)
    end

    def session_id # :nodoc:
      return @session_id if @session_id && (incept + FifteenMins > Time.now)

      response = connector.get("createsession#{ResponseFormat}/#{developerId}/#{signature('createsession')}/#{timestamp}")
      raise Error("Failed to retrieve a session ID from #{connector.url}") unless response.status == 200

      @session_id = response.body['session_id']
    end

    def boilerplate(meth) #:nodoc:
      "#{meth}#{ResponseFormat}/#{developerId}/#{signature(meth)}/#{session_id}/#{timestamp}"
    end

    # Sets the champion_id on the connection and returns the connection
    def for_champion(id)
      self.champion_id = id
      yield(self)
    end

    # Sets the language on the connection and returns the connection
    # Accepts either a language_code or the language name as a symbol
    def in_language(name_or_id)
      self.language_code = name_or_id.is_a?(Numeric) ? name_or_id : LanguageCode[name_or_id]
      yield(self)
    end

    Portal.each_key do |portal|
      define_method(portal) do
        instance_variable_set(:@portal_id, Portal[portal])
        self
      end
    end

    # Synchronously retrieve the response from the Hirez WEB API
    def get
      # NOTE: The html error page returned from Hirez breaks the json parser. I just ignore that and
      # retrieve the original response
      start = Time.now
      5.times do
        begin
          result = connector.get(@url)
        rescue Faraday::ParsingError => e
          result = e.response
        end
        case
        when (200..300).include?(result.status)
          return result.body
        when result.status == 408
          puts '* Server Timeout detected... Retrying'
        when result.status == 504
          puts '* Gateway Timeout detected... Retrying'
        else
          raise(Error, "API Response Error:\n#{textify(result.body)}")
        end
      end
      puts "* Timeout detected... Terminating after #{Time.new - start} seconds"
      ''
    end

    def textify(html) # :nodoc:
      return html unless html =~ /<head>/

      body = html[%r{<body>(.*)</body>}m,1]
      body.split(/<p[^>]*>/)[1..-1].map { |txt| txt.sub(%r{</p>.*}m, "") }.join(": ")
    end
  end

end
