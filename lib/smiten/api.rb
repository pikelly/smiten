module Smiten
  class Connector < OpenStruct
    def core_api
      { ping:                                   [nil,    -> { "ping#{ResponseFormat}" }, {}],
        create_session:                         [nil,    -> { "#{boilerplate('createsession')}/#{timestamp}" }, {}],
        test_session:                           [nil,    -> { "#{boilerplate('testsession')}" }, {}],
        get_data_used:                          [nil,    -> { "#{boilerplate('getdataused')}" }, {}],
        get_hirez_server_status:                [nil,    -> { "#{boilerplate('gethirezserverstatus')}" }, {}],
        get_patch_info:                         [nil,    -> { "#{boilerplate('getpatchinfo')}" }, {}],
        get_items:                              ['Item', -> { "#{boilerplate('getitems')}/#{language_code}" }, {}],
        get_bounty_items:                       [nil,    -> { "#{boilerplate('getbountyitems')}" }, {}],
        get_player_id_by_name:                  [nil,    -> { "#{boilerplate('getplayeridbyname')}/#{player_name}" }, { player_name: 'conygred' }],
        get_player_id_by_portal_user_id:        [nil,    -> { "#{boilerplate('getplayeridbyportaluserid')}/#{portal_id}/#{portal_user_id}" }, { portal_id: Portal[:xbox], portal_user_id: 2535432204002199 }],
        get_player_ids_by_gamer_tag:            [nil,    -> { "#{boilerplate('getplayeridsbygamertag')}/#{portal_id}/#{gamer_tag}" }, { portal_id: 9999, gamer_tag: 'conygred' }],
        get_player_id_info_for_xbox_and_switch: [nil,    -> { "#{boilerplate('getplayeridinfoforxboxandswitch')}/#{player_name}" }, { player_name: 'conygred' }],
        get_friends:                            [nil,    -> { "#{boilerplate('getfriends')}/#{player_id}" }, { player_id: 720885066 }],
        get_player_loadouts:                    [nil,    -> { "#{boilerplate('getplayerloadouts')}/#{player_id}/#{language_code}" }, { player_id: 720885066 }],
        get_player_achievements:                [nil,    -> { "#{boilerplate('getplayerachievements')}/#{player_id}" }, { player_id: 720885066 }],
        get_player_status:                      [nil,    -> { "#{boilerplate('getplayerstatus')}/#{player_id}" }, { player_id: 720885066 }],
        get_match_history:                      [nil,    -> { "#{boilerplate('getmatchhistory')}/#{player_id}" }, { player_id: 720885066 }],
        get_queue_stats:                        [nil,    -> { "#{boilerplate('getqueuestats')}/#{player_id}/#{queue_id}" }, { player_id: 720885066, queue_id:424 }],
        search_players:                         [nil,    -> { "#{boilerplate('searchplayers')}/#{search_string}" }, { search_string: 'conygred' }],
        get_demo_details:                       [nil,    -> { "#{boilerplate('getdemodetails')}/#{match_id}" }, { match_id: 9999 }],
        get_match_details:                      [nil,    -> { "#{boilerplate('getmatchdetails')}/#{match_id}" }, { match_id: 9999 }],
        get_match_details_batch:                [nil,    -> { "#{boilerplate('getmatchdetailsbatch')}/#{match_ids.map(&:to_s).join(',')}" }, { match_ids: [9999,9998] }],
        get_match_ids_by_queue:                 [nil,    -> { "#{boilerplate('getmatchidsbyqueue')}/#{queue_id}" }, { queue_id: 424 }],
        get_match_player_details:               [nil,    -> { "#{boilerplate('getmatchplayerdetails')}/#{match_id}" }, { match_id: 9999 }],
        get_top_matches:                        [nil,    -> { "#{boilerplate('gettopmatches')}" }, {}],
        get_league_leaderboard:                 [nil,    -> { "#{boilerplate('getleagueleaderboard')}/#{queue_id}/#{tier}/#{round}" }, { queue_id: 424, tier: 9999, round: 9999 }],
        get_league_seasons:                     [nil,    -> { "#{boilerplate('getleagueseasons')}/{queue_id}" }, { queue_id: 424 }],
        get_team_details:                       [nil,    -> { "#{boilerplate('getteamdetails')}/#{team_id}" }, { team_id: 9999 }],
        get_team_players:                       [nil,    -> { "#{boilerplate('getteamplayers')}/#{team_id}" }, { team_id: 9999 }],
        search_teams:                           [nil,    -> { "#{boilerplate('searchteams')}/#{search_string}" }, { search_string: 'hello' }],
        get_esports_proleague_details:          [nil,    -> { "#{boilerplate('getesportsproleaguedetails')}" }, {}],
        get_motd:                               [nil,    -> { "#{boilerplate('getmotd')}"}, {} ]
      }
    end
  end
end