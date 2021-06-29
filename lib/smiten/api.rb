module Smiten
  class Core < OpenStruct
    # Returns a hash containing the API signatures keyed by ruby method name
    def core_api
      { ping:                                   [nil,      -> { "ping#{ResponseFormat}" }],
        create_session:                         [nil,      -> { "#{boilerplate('createsession')}/#{timestamp}" }],
        test_session:                           [nil,      -> { "#{boilerplate('testsession')}" }],
        get_data_used:                          [nil,      -> { "#{boilerplate('getdataused')}" }],
        get_hirez_server_status:                [nil,      -> { "#{boilerplate('gethirezserverstatus')}" }],
        get_patch_info:                         [nil,      -> { "#{boilerplate('getpatchinfo')}" }],
        get_items:                              ['Item',   -> { "#{boilerplate('getitems')}/#{language_code}" }],
        get_bounty_items:                       [nil,      -> { "#{boilerplate('getbountyitems')}" }],
        get_player:                             ['Player', -> { "#{boilerplate('getplayer')}/#{player}#{"/#{portal_id}" if portal_id }"}],
        get_player_batch:                       ['Player', -> { "#{boilerplate('getplayerbatch')}/#{player_ids.map(&:to_s).join(',')}" }],
        get_player_id_by_name:                  [nil,      -> { "#{boilerplate('getplayeridbyname')}/#{player_name}" }],
        get_player_id_by_portal_user_id:        [nil,      -> { "#{boilerplate('getplayeridbyportaluserid')}/#{portal_id}/#{portal_user_id}" }],
        get_player_ids_by_gamer_tag:            [nil,      -> { "#{boilerplate('getplayeridsbygamertag')}/#{portal_id}/#{gamer_tag}" }],
        get_friends:                            [nil,      -> { "#{boilerplate('getfriends')}/#{player_id}" }],
        get_player_status:                      [nil,      -> { "#{boilerplate('getplayerstatus')}/#{player_id}" }],
        get_match_history:                      [nil,      -> { "#{boilerplate('getmatchhistory')}/#{player_id}" }],
        get_queue_stats:                        [nil,      -> { "#{boilerplate('getqueuestats')}/#{player_id}/#{queue_id}" }],
        search_players:                         [nil,      -> { "#{boilerplate('searchplayers')}/#{search_string}" }],
        get_demo_details:                       [nil,      -> { "#{boilerplate('getdemodetails')}/#{match_id}" }],
        get_match_details:                      [nil,      -> { "#{boilerplate('getmatchdetails')}/#{match_id}" }],
        get_match_details_batch:                [nil,      -> { "#{boilerplate('getmatchdetailsbatch')}/#{match_ids.map(&:to_s).join(',')}" }],
        get_match_ids_by_queue:                 [nil,      -> { "#{boilerplate('getmatchidsbyqueue')}/#{queue_id}/#{date}/#{hour}" }],
        get_match_player_details:               [nil,      -> { "#{boilerplate('getmatchplayerdetails')}/#{match_id}" }],
        get_top_matches:                        [nil,      -> { "#{boilerplate('gettopmatches')}" }],
        get_league_leaderboard:                 [nil,      -> { "#{boilerplate('getleagueleaderboard')}/#{queue_id}/#{tier}/#{round}" }],
        get_league_seasons:                     [nil,      -> { "#{boilerplate('getleagueseasons')}/#{queue_id}" }],
        get_team_details:                       [nil,      -> { "#{boilerplate('getteamdetails')}/#{team_id}" }],
        get_team_players:                       [nil,      -> { "#{boilerplate('getteamplayers')}/#{team_id}" }],
        get_esports_proleague_details:          [nil,      -> { "#{boilerplate('getesportsproleaguedetails')}" }],
        get_motd:                               [nil,      -> { "#{boilerplate('getmotd')}"}]
      }
    end
  end
end