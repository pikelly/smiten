# frozen_string_literal: true

module Smiten
  PaladinsEndpoint = 'https://api.paladins.com/paladinsapi.svc'
  SmiteEndpoint    = 'https://api.smitegame.com/smiteapi.svc'
  FifteenMins = (15 * 60 * 60) - 10
  ResponseFormat = 'Json'
  Portal = { hi_rez: 1, steam: 5, ps4: 9, xbox: 10, switch: 22, discord: 25, epic: 28 }.freeze
  LanguageCode = { English: 1, German: 2, French: 3, Chinese: 5, Spanish: 7, Spanish_Latin_America: 9, Portuguese: 10, Russian: 11, Polish: 12 }.freeze

  require_relative 'api'

  class Error < StandardError; end

  class Connector < OpenStruct
    attr_reader :connector
    attr_accessor :developerId, :authKey, :language_code, :portal, :calls

    def set_calls
      @calls = @calls.merge!(core_api).freeze
      calls.each_key do |api|
        unless self.class.method_defined?(api)
          self.class.define_method(api) do |args = {}|
            args.each_pair do |key, value|
              send("#{key}=", value)
            end
            @url = calls[api][1].call
            payload = get
            { kind: calls[api][0], payload: payload }
          end
        end
      end
    end

    def initialize(options)
      options.merge!(headers: { 'Content-Type' => 'application/json' }, request: { timeout: 30 })
      @developerId = options.delete(:developerId)
      @authKey = options.delete(:authKey)
      @language_code = LanguageCode[:English]
      @portal = nil
      @connector = Faraday.new(options) do |f|
        f.request :json # encode req bodies as JSON
        f.request :retry # retry transient failures
        f.response :json # decode response bodies as JSON
      end
      set_calls
      super
    end

    def incept
      @incept ||= Time.now
    end

    def timestamp
      @timestamp ||= incept.getutc.strftime('%Y%m%d%H%M%S')
    end

    def signature(api_call)
      Digest::MD5.hexdigest(developerId + api_call.to_s + authKey + timestamp)
    end

    def session_id
      return @session_id if @session_id && (incept + FifteenMins > Time.now)

      response = connector.get("createsession#{ResponseFormat}/#{developerId}/#{signature('createsession')}/#{timestamp}")
      raise Error("Failed to retrieve a session ID from #{connector.url}") unless response.status == 200

      @session_id = response.body['session_id']
    end

    def boilerplate(meth)
      "#{meth}#{ResponseFormat}/#{developerId}/#{signature(meth)}/#{session_id}/#{timestamp}"
    end

    # getplayer: "#{boilerplate('getplayer')}/#{player_id}/#{portal_id}" }, { player_id: 9999 }],
    # getplayer:  "#{boilerplate('getplayer')}#', #"/{player_id}"}, { player_id: 9999}],
    # getplayers: "#{boilerplate('getplayerbatch')#/#{#'player_ids.map(&:to_s).join(',') if ids}"}, { player_ids: [8888, 9999] }],
    def getplayer(name_or_list, portal = nil)
      self.portal = portal if portal
      @url = if name_or_list.is_a?(Array)
               "getplayerbatch#{boilerplate('getplayerbatch')}/#{name_or_list.join(',')}"
             else
               player_url(name_or_list)
             end
      payload = get
      payload[0]['id'] = payload[0]['Active_player_id']
      { kind: 'Player', payload: payload[0] }
    end

    def player_url(name)
      case portal
      when Portal[:xbox]
        info = getplayeridinfoforxboxandswitch(name)[:payload]
        raise 'Ambiguous user error for #(name) when querying xbox' if info.is_a?(Array)
      end
      "getplayer#{ResponseFormat}/#{developerId}/#{signature('getplayer')}/#{session_id}/#{timestamp}/#{name}/#{portal}"
    end

    def for_champion(id)
      self.id = id
      yield(self)
    end

    def in_language(name_or_id)
      self.language_code = name_or_id.is_a?(Numeric) ? name_or_id : LanguageCode[name_or_id]
      yield(self)
    end

    Portal.each_key do |portal|
      define_method(portal) do
        instance_variable_set(:@portal, Portal[portal])
        self
      end
    end

    def get
      response = ''
      5.times do
        result = connector.get(@url)
        response = result.body
        break
      rescue Faraday::ParsingError => e
        if e.message.is_a?(String)
          case e.message
          when /Time-out/
            puts '* Timeout detected... Retrying'
          when /Request Error/
            raise Error("Malformed API call:\n#{e.message}")
          else
            raise Error("Remote Service Error:\n#{e.message}")
          end
        end
      end
      response
    end
  end

end
