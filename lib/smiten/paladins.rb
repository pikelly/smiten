module Smiten
  class Paladins < Connector
    def initialize(options)
      options.merge!(url: PaladinsEndpoint)
      super(options)
    end

    def set_calls
      @calls = {
        getchampions:                ['Champion',     -> { "#{boilerplate('getchampions')}/#{language_code}" }, {}],
        getchampioncards:            ['ChampionCard', -> { "#{boilerplate('getchampioncards')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
        getchampionskins:            ['ChampionSkin', -> { "#{boilerplate('getchampionskins')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
        getchampionleaderboard:      [nil,            -> { "#{boilerplate('getchampionleaderboard')}/#{champion_id}/#{queue_id}" }, {champion_id: 2056, queue_id: 424}],
        getchampionrecommendeditems: [nil,            -> { "#{boilerplate('getchampionrecommendeditems')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
        getchampionranks:            [nil,            -> { "#{boilerplate('getchampionranks')}/#{champion_id}" }, {champion_id: 2056}],
      }
      super
    end
  end
end