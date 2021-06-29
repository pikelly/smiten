module Smiten
  # The Paladins class implements those calls that are specific to the Paladins endpoint
  class Paladins < Core
    # See Core for details
    def initialize(options)
      super(options)
    end

    def build_apis # :nodoc:
      # Obsolete: get_champion_recommended_items: [nil,            -> { "#{boilerplate('getchampionrecommendeditems')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
      @calls = {
        get_champions:                          ['Champion',     -> { "#{boilerplate('getchampions')}/#{language_code}" }],
        get_champion_cards:                     ['ChampionCard', -> { "#{boilerplate('getchampioncards')}/#{champion_id}/#{language_code}" }],
        get_champion_skins:                     ['ChampionSkin', -> { "#{boilerplate('getchampionskins')}/#{champion_id}/#{language_code}" }],
        get_champion_leaderboard:               [nil,            -> { "#{boilerplate('getchampionleaderboard')}/#{champion_id}/#{queue_id}" }],
        get_champion_ranks:                     [nil,            -> { "#{boilerplate('getchampionranks')}/#{player_id}" }],
        get_player_id_info_for_xbox_and_switch: [nil,            -> { "#{boilerplate('getplayeridinfoforxboxandswitch')}/#{player_name}" }],
        get_player_loadouts:                    [nil,            -> { "#{boilerplate('getplayerloadouts')}/#{player_id}/#{language_code}" }],
      }
      super
    end
  end
end