module Smiten
  class Smite < Connector
    def initialize(options)
      options.merge!(url: SmiteEndpoint)
      super(options)
    end

    def set_calls
      @calls = {
        getgods:                [ 'God',     -> { "#{boilerplate('getgods')}/#{language_code}"}],
        getgodleaderboard:      [ nil,       -> { "#{boilerplate('getgodleaderboard')}/#{god_id}/#{queue_id}"}, {god_id: 9999, queue_id: 424}],
        getgodskins:            [ 'GodSkin', -> { "#{boilerplate('getgodskins')}/#{god_id}/#{language_code}"}, {god_id: 9999}],
        getgodrecommendeditems: [ nil,       -> { "#{boilerplate('getgodrecommendeditems')}/#{god_id}/#{language_code}"}, {god_id: 9999}],
        getgodranks:            [ nil,       -> { "#{boilerplate('getgodranks')}/#{god_id}"}, {god_id: 9999}],
      }
      super
    end
  end
end