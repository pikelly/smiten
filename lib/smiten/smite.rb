module Smiten
  # The Smite class implements those calls that are specific to the Smite endpoint
  class Smite < Core
    # See Core
    def initialize(options)
      options.merge!(url: SmiteEndpoint)
      super(options)
    end

    def build_apis # :nodoc:
      @calls = {
        get_gods:                  ['God',     -> { "#{boilerplate('getgods')}/#{language_code}"}],
        get_god_leaderboard:       [nil,       -> { "#{boilerplate('getgodleaderboard')}/#{god_id}/#{queue_id}"}],
        get_god_skins:             ['GodSkin', -> { "#{boilerplate('getgodskins')}/#{god_id}/#{language_code}"}],
        get_god_recommended_items: [nil,       -> { "#{boilerplate('getgodrecommendeditems')}/#{god_id}/#{language_code}"}],
        get_god_ranks:             [nil,       -> { "#{boilerplate('getgodranks')}/#{player_id}"}],
        get_player_achievements:   [nil,       -> { "#{boilerplate('getplayerachievements')}/#{player_id}" }],
        search_teams:              [nil,       -> { "#{boilerplate('searchteams')}/#{search_string}" }],
      }
      super
    end
  end
end