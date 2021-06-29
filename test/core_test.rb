# frozen_string_literal: true

require "test_helper"

class CoreTest < Minitest::Test
  include Smiten::Test::Common

  def setup
    creds = YAML.load_file(__dir__ + '/../.creds')
    @api = Smiten::Core.new(creds)
  end

  # create_session:                         [nil,    -> { "#{boilerplate('createsession')}/#{timestamp}" }, {}],
  # We skip this one ;-)

  # ping:                                   [nil,    -> { "ping#{ResponseFormat}" }, {}],
  def test_ping
    # PaladinsAPI (ver 0.0.41.24828) [PATCH - 4.4] - Ping successful. Server Date:6/28/2021 10:23:09 AM
    payload = query(@api.ping)
    assert_match(/Ping successful/, payload)
  end
  # test_session:                           [nil,    -> { "#{boilerplate('testsession')}" }, {}],
  def test_test_session
    # This was a successful test with the following parameters added: developer: XXXX time: 6/28/2021 10:07:31 AM signature: YYYY session: ZZZZ
    payload = query(@api.test_session)
    assert_match(/successful test/, payload)
  end
  # get_data_used:                          [nil,    -> { "#{boilerplate('getdataused')}" }, {}],
  def test_get_data_used
    # {"Active_Sessions"=>1,
    #  "Concurrent_Sessions"=>50,
    #  "Request_Limit_Daily"=>7500,
    #  "Session_Cap"=>500,
    #  "Session_Time_Limit"=>15,
    #  "Total_Requests_Today"=>63,
    #  "Total_Sessions_Today"=>23,
    #  "ret_msg"=>nil}
    payload = query(@api.get_data_used)
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{ Active_Sessions Concurrent_Sessions Request_Limit_Daily Session_Cap Session_Time_Limit Total_Requests_Today Total_Sessions_Today ret_msg })
  end
  # get_hirez_server_status:                [nil,    -> { "#{boilerplate('gethirezserverstatus')}" }, {}],
  def test_get_hirez_server_status
    # {"entry_datetime"=>"2021-06-28 11:36:25.359",
    #  "environment"=>"live",
    #  "limited_access"=>false,
    #  "platform"=>"pc",
    #  "ret_msg"=>nil,
    #  "status"=>"UP",
    #  "version"=>"4.4.4103.0"}
    payload = query(@api.get_hirez_server_status)
    assert_sized_array_of_hashes_with_keys(payload, 5, %w{entry_datetime environment limited_access platform ret_msg status version})
  end
  # get_patch_info:                         [nil,    -> { "#{boilerplate('getpatchinfo')}" }, {}],
  def test_get_patch_info
    # {"ret_msg"=>nil, "version_string"=>"4.4"}
    payload = query(@api.get_patch_info)
    assert_instance_of(Hash, payload)
    assert payload.keys.sort == %w{ret_msg version_string}
  end
  # get_items:                              ['Item', -> { "#{boilerplate('getitems')}/#{language_code}" }, {}],
  def test_get_items
    # {"Description"=>
    #  "[Weapon] Your weapon shots deal {20}% increased Damage to Deployables, Pets, and Illusions.",
    #  "DeviceName"=>"Bulldozer",
    #  "IconId"=>4361,
    #  "ItemId"=>13079,
    #  "Price"=>150,
    #  "ShortDesc"=>"",
    #  "champion_id"=>0,
    #  "itemIcon_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-items/bulldozer.jpg",
    #  "item_type"=>"Burn Card Damage Vendor",
    #  "recharge_seconds"=>0,
    #  "ret_msg"=>nil,
    #  "talent_reward_level"=>0}
    payload = query(@api.get_items)
    assert_sized_array_of_hashes_with_keys(payload, '978+', %w{Description DeviceName IconId ItemId Price ShortDesc champion_id itemIcon_URL item_type recharge_seconds ret_msg talent_reward_level})
  end
  # get_bounty_items:                       [nil,    -> { "#{boilerplate('getbountyitems')}" }, {}],
  def test_get_bounty_items
    # {"active"=>"n",
    #  "bounty_item_id1"=>65978,
    #  "bounty_item_id2"=>21260,
    #  "bounty_item_name"=>"Battlesuit Eagle Eye",
    #  "champion_id"=>2249,
    #  "champion_name"=>"Kinessa",
    #  "final_price"=>"241",
    #  "initial_price"=>"277",
    #  "ret_msg"=>nil,
    #  "sale_end_datetime"=>"3/31/2021 12:00:00 PM",
    #  "sale_type"=>"Decreasing"}
    payload = query(@api.get_bounty_items)
    assert_sized_array_of_hashes_with_keys(payload, '10+', %w{active bounty_item_id1 bounty_item_id2 bounty_item_name champion_id champion_name final_price initial_price ret_msg sale_end_datetime sale_type})
  end
  # get_player_id_by_name:                  [nil,    -> { "#{boilerplate('getplayeridbyname')}/#{player_name}" }, { player_name: 'conygred' }],
  def test_get_player_id_by_name
    # {"Name"=>"conygred",
    #  "player_id"=>724806491,
    #  "portal"=>"Steam",
    #  "portal_id"=>"5",
    #  "privacy_flag"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_id_by_name({ player_name: 'conygred' }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Name player_id portal portal_id privacy_flag ret_msg})
  end
  # get_player_id_by_portal_user_id:        [nil,    -> { "#{boilerplate('getplayeridbyportaluserid')}/#{portal_id}/#{portal_user_id}" }, { portal_id: Portal[:xbox], portal_user_id: 2535432204002199 }],
  def test_get_player_id_by_portal_user_id
    # {"Name"=>nil,
    #  "player_id"=>720885066,
    #  "portal"=>"Xbox",
    #  "portal_id"=>"10",
    #  "privacy_flag"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_id_by_portal_user_id({ portal_id: Smiten::Portal[:xbox], portal_user_id: Conygred[:xbox_id] }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Name player_id portal portal_id privacy_flag ret_msg})
  end
  #   get_player_ids_by_gamer_tag:            [nil,    -> { "#{boilerplate('getplayeridsbygamertag')}/#{portal_id}/#{gamer_tag}" }, { portal_id: 9999, gamer_tag: 'conygred' }],
  def test_player_ids_by_gamer_tag
    # {"Name"=>"conygred",
    #  "player_id"=>720885066,
    #  "portal"=>"Xbox",
    #  "portal_id"=>"10",
    #  "privacy_flag"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_ids_by_gamer_tag({ portal_id: Smiten::Portal[:xbox], gamer_tag: 'conygred' }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Name player_id portal portal_id privacy_flag ret_msg})
  end
  # get_friends:                            [nil,    -> { "#{boilerplate('getfriends')}/#{player_id}" }, { player_id: 720885066 }],
  def test_get_friends
    # {"account_id"=>"1143920223",
    #  "friend_flags"=>"1",
    #  "name"=>"unai2002",
    #  "player_id"=>"721232042",
    #  "portal_id"=>"5",
    #  "ret_msg"=>nil,
    #  "status"=>"Friend"}
    payload = query(@api.get_friends({ player_id: Conygred[:player_id] }))
    assert_sized_array_of_hashes_with_keys(payload, "1+", %w{account_id friend_flags name player_id portal_id ret_msg status})
  end
  # get_player:                             ['Player', -> { "#{boilerplate('getplayer')}/#{player}#{"/#{portal_id}" if portal }"}],
  def test_get_player_using_portal_and_portal_id
    # This returns nothing
    payload = query(@api.xbox.get_player({ player: Conygred[:xbox_id] }))
    assert_sized_array_of_hashes_with_keys(payload, 0 , %w{account_id friend_flags name player_id portal_id ret_msg status})
    # TODO: why does this return an empty array, and fix the payload size
  end
  def test_get_player_using_player_id
    # This returns the hirez player data
    # {"ActivePlayerId"=>720885066,
    #  "AvatarId"=>25507,
    #  "AvatarURL"=>"https://hirez-api-docs.herokuapp.com/paladins/avatar/25507",
    #  "Created_Datetime"=>"7/10/2020 5:46:41 PM",
    #  "HoursPlayed"=>655,
    #  "Id"=>720885066,
    #  "Last_Login_Datetime"=>"6/29/2021 5:50:24 PM",
    #  "Leaves"=>0,
    #  "Level"=>241,
    #  "LoadingFrame"=>nil,
    #  "Losses"=>973,
    #  "MasteryLevel"=>48,
    #  "MergedPlayers"=>nil,
    #  "MinutesPlayed"=>39314,
    #  "Name"=>"conygred",
    #  "Personal_Status_Message"=>"",
    #  "Platform"=>"XboxLive",
    #  "RankedConquest"=>
    #   {"Leaves"=>0,
    #    "Losses"=>1,
    #    "Name"=>"Conquest",
    #    "Points"=>0,
    #    "PrevRank"=>0,
    #    "Rank"=>0,
    #    "Season"=>5,
    #    "Tier"=>0,
    #    "Trend"=>0,
    #    "Wins"=>0,
    #    "player_id"=>nil,
    #    "ret_msg"=>nil},
    #  "RankedController"=>
    #   {"Leaves"=>0,
    #    "Losses"=>1,
    #    "Name"=>"Ranked Controller",
    #    "Points"=>0,
    #    "PrevRank"=>0,
    #    "Rank"=>0,
    #    "Season"=>5,
    #    "Tier"=>0,
    #    "Trend"=>0,
    #    "Wins"=>0,
    #    "player_id"=>nil,
    #    "ret_msg"=>nil},
    #  "RankedKBM"=>
    #   {"Leaves"=>0,
    #    "Losses"=>0,
    #    "Name"=>"Ranked KBM",
    #    "Points"=>0,
    #    "PrevRank"=>0,
    #    "Rank"=>0,
    #    "Season"=>0,
    #    "Tier"=>0,
    #    "Trend"=>0,
    #    "Wins"=>0,
    #    "player_id"=>nil,
    #    "ret_msg"=>nil},
    #  "Region"=>"Europe",
    #  "TeamId"=>0,
    #  "Team_Name"=>"",
    #  "Tier_Conquest"=>0,
    #  "Tier_RankedController"=>0,
    #  "Tier_RankedKBM"=>0,
    #  "Title"=>"Runs the Show",
    #  "Total_Achievements"=>44,
    #  "Total_Worshippers"=>233685218,
    #  "Total_XP"=>217463983,
    #  "Wins"=>929,
    #  "hz_gamer_tag"=>"conygred",
    #  "hz_player_name"=>nil,
    #  "ret_msg"=>nil}
    payload = query(@api.get_player({ portal_id: nil, player: 720885066 }))
    assert_sized_array_of_hashes_with_keys(payload, "1+", %w{ActivePlayerId AvatarId AvatarURL Created_Datetime HoursPlayed Id Last_Login_Datetime Leaves Level LoadingFrame Losses MasteryLevel MergedPlayers MinutesPlayed Name Personal_Status_Message Platform RankedConquest RankedController RankedKBM Region TeamId Team_Name Tier_Conquest Tier_RankedController Tier_RankedKBM Title Total_Achievements Total_Worshippers Total_XP Wins hz_gamer_tag hz_player_name ret_msg})
  end
  def test_get_player_using_player_name
    # This returns the steam user account
    payload = query(@api.get_player({ portal_id: nil, player: 'conygred' }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{ActivePlayerId AvatarId AvatarURL Created_Datetime HoursPlayed Id Last_Login_Datetime Leaves Level LoadingFrame Losses MasteryLevel MergedPlayers MinutesPlayed Name Personal_Status_Message Platform RankedConquest RankedController RankedKBM Region TeamId Team_Name Tier_Conquest Tier_RankedController Tier_RankedKBM Title Total_Achievements Total_Worshippers Total_XP Wins hz_gamer_tag hz_player_name ret_msg})
  end
  # get_player_batch:                       ['Player', -> { "#{boilerplate('getplayerbatch')}/#{player_ids.map(&:to_s).join(',')}" }],
  def test_get_player_batch
    payload = query(@api.get_player_batch({ player_ids: [720885066, 505648429] }))
    assert_sized_array_of_hashes_with_keys(payload, 2, %w{ActivePlayerId AvatarId AvatarURL Created_Datetime HoursPlayed Id Last_Login_Datetime Leaves Level LoadingFrame Losses MasteryLevel MergedPlayers MinutesPlayed Name Personal_Status_Message Platform RankedConquest RankedController RankedKBM Region TeamId Team_Name Tier_Conquest Tier_RankedController Tier_RankedKBM Title Total_Achievements Total_Worshippers Total_XP Wins hz_gamer_tag hz_player_name ret_msg})
  end
  # get_player_status:                      [nil,    -> { "#{boilerplate('getplayerstatus')}/#{player_id}" }, { player_id: 720885066 }],
  def test_get_player_status
    # {"Match"=>0,
    #  "match_queue_id"=>0,
    #  "personal_status_message"=>nil,
    #  "ret_msg"=>nil,
    #  "status"=>0,
    #  "status_string"=>"Offline"}
    payload = query(@api.get_player_status({ player_id: 720885066 }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Match match_queue_id personal_status_message ret_msg status status_string})
  end
  #  et_match_history:                      [nil,    -> { "#{boilerplate('getmatchhistory')}/#{player_id}" }, { player_id: 720885066 }],
  def test_get_match_history
    # {"ActiveId1"=>13235,
    #  "ActiveId2"=>11826,
    #  "ActiveId3"=>12010,
    #  "ActiveId4"=>0,
    #  "ActiveLevel1"=>8,
    #  "ActiveLevel2"=>0,
    #  "ActiveLevel3"=>8,
    #  "ActiveLevel4"=>0,
    #  "Active_1"=>"Deft Hands",
    #  "Active_2"=>"Nimble",
    #  "Active_3"=>"Life Rip",
    #  "Active_4"=>"",
    #  "Assists"=>25,
    #  "Champion"=>"Tiberius",
    #  "ChampionId"=>2529,
    #  "Creeps"=>2,
    #  "Damage"=>71452,
    #  "Damage_Bot"=>0,
    #  "Damage_Done_In_Hand"=>53606,
    #  "Damage_Mitigated"=>0,
    #  "Damage_Structure"=>0,
    #  "Damage_Taken"=>22268,
    #  "Damage_Taken_Magical"=>0,
    #  "Damage_Taken_Physical"=>22268,
    #  "Deaths"=>3,
    #  "Distance_Traveled"=>0,
    #  "Gold"=>3724,
    #  "Healing"=>0,
    #  "Healing_Bot"=>0,
    #  "Healing_Player_Self"=>8577,
    #  "ItemId1"=>25167,
    #  "ItemId2"=>25173,
    #  "ItemId3"=>25169,
    #  "ItemId4"=>25176,
    #  "ItemId5"=>25164,
    #  "ItemId6"=>25180,
    #  "ItemLevel1"=>5,
    #  "ItemLevel2"=>3,
    #  "ItemLevel3"=>2,
    #  "ItemLevel4"=>2,
    #  "ItemLevel5"=>3,
    #  "ItemLevel6"=>0,
    #  "Item_1"=>"Bragging Rights",
    #  "Item_2"=>"Crowd-Pleaser",
    #  "Item_3"=>"Instrument of Fate",
    #  "Item_4"=>"World-traveler",
    #  "Item_5"=>"Flying Chakrams",
    #  "Item_6"=>"Predatory Instincts",
    #  "Killing_Spree"=>16,
    #  "Kills"=>8,
    #  "Level"=>0,
    #  "Map_Game"=>"Practice Primal Court (Onslaught)",
    #  "Match"=>1103046212,
    #  "Match_Queue_Id"=>453,
    #  "Match_Time"=>"6/28/2021 6:40:47 PM",
    #  "Minutes"=>8,
    #  "Multi_kill_Max"=>1,
    #  "Objective_Assists"=>111,
    #  "Queue"=>"Onslaught Training",
    #  "Region"=>"EU",
    #  "Skin"=>"Default Tiberius",
    #  "SkinId"=>24885,
    #  "Surrendered"=>0,
    #  "TaskForce"=>1,
    #  "Team1Score"=>4,
    #  "Team2Score"=>3,
    #  "Time_In_Match_Seconds"=>480,
    #  "Wards_Placed"=>0,
    #  "Win_Status"=>"Win",
    #  "Winning_TaskForce"=>1,
    #  "playerId"=>720885066,
    #  "playerName"=>"conygred",
    #  "ret_msg"=>nil}
    payload = query(@api.get_match_history({ player_id: 720885066 }))
    assert_sized_array_of_hashes_with_keys(payload, "10+", %w{ActiveId1 ActiveId2 ActiveId3 ActiveId4 ActiveLevel1 ActiveLevel2 ActiveLevel3 ActiveLevel4 Active_1 Active_2 Active_3 Active_4 Assists Champion ChampionId Creeps Damage Damage_Bot Damage_Done_In_Hand Damage_Mitigated Damage_Structure Damage_Taken Damage_Taken_Magical Damage_Taken_Physical Deaths Distance_Traveled Gold Healing Healing_Bot Healing_Player_Self ItemId1 ItemId2 ItemId3 ItemId4 ItemId5 ItemId6 ItemLevel1 ItemLevel2 ItemLevel3 ItemLevel4 ItemLevel5 ItemLevel6 Item_1 Item_2 Item_3 Item_4 Item_5 Item_6 Killing_Spree Kills Level Map_Game Match Match_Queue_Id Match_Time Minutes Multi_kill_Max Objective_Assists Queue Region Skin SkinId Surrendered TaskForce Team1Score Team2Score Time_In_Match_Seconds Wards_Placed Win_Status Winning_TaskForce playerId playerName ret_msg})
  end
  # get_queue_stats:                        [nil,    -> { "#{boilerplate('getqueuestats')}/#{player_id}/#{queue_id}" }, { player_id: 720885066, queue_id:424 }],
  def test_get_queue_stats
    # {"Assists"=>2302,
    #  "Champion"=>"Vivian",
    #  "ChampionId"=>2480,
    #  "Deaths"=>1683,
    #  "Gold"=>609246,
    #  "Kills"=>2520,
    #  "LastPlayed"=>"4/2/2021 6:25:46 PM",
    #  "Losses"=>104,
    #  "Matches"=>226,
    #  "Minutes"=>2710,
    #  "Queue"=>"",
    #  "Wins"=>122,
    #  "player_id"=>"720885066",
    #  "ret_msg"=>nil}
    payload = query(@api.get_queue_stats({player_id: 720885066, queue_id: Smiten::QueueCode[:live_siege]}))
    assert_sized_array_of_hashes_with_keys(payload, "40+", %w{Assists Champion ChampionId Deaths Gold Kills LastPlayed Losses Matches Minutes Queue Wins player_id ret_msg})
  end
  # search_players:                         [nil,    -> { "#{boilerplate('searchplayers')}/#{search_string}" }, { search_string: 'conygred' }],
  def test_search_players
    # {"Name"=>"conygred",
    #  "hz_player_name"=>"conygred",
    #  "player_id"=>"724806491",
    #  "portal_id"=>"5",
    #  "privacy_flag"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.search_players({search_string: 'conygr' }))
    assert_sized_array_of_hashes_with_keys(payload, "1+", %w{Name hz_player_name player_id portal_id privacy_flag ret_msg})
  end
  # get_demo_details:                       [nil,    -> { "#{boilerplate('getdemodetails')}/#{match_id}" }, { match_id: 9999 }],
  def test_demo_details
    # Rarely used. Use get_match_details.
  end
  # get_match_details:                      [nil,    -> { "#{boilerplate('getmatchdetails')}/#{match_id}" }, { match_id: 9999 }],
  def test_get_match_details
    # "Account_Level"=>20,
    #  "ActiveId1"=>13165,
    #  "ActiveId2"=>13075,
    #  "ActiveId3"=>13229,
    #  "ActiveId4"=>12010,
    #  "ActiveLevel1"=>0,
    #  "ActiveLevel2"=>0,
    #  "ActiveLevel3"=>0,
    #  "ActiveLevel4"=>0,
    #  "ActivePlayerId"=>"702681625",
    #  "Assists"=>15,
    #  "BanId1"=>0,
    #  "BanId2"=>0,
    #  "BanId3"=>0,
    #  "BanId4"=>0,
    #  "Ban_1"=>nil,
    #  "Ban_2"=>nil,
    #  "Ban_3"=>nil,
    #  "Ban_4"=>nil,
    #  "Camps_Cleared"=>0,
    #  "ChampionId"=>2285,
    #  "Damage_Bot"=>0,
    #  "Damage_Done_In_Hand"=>43996,
    #  "Damage_Done_Magical"=>0,
    #  "Damage_Done_Physical"=>53716,
    #  "Damage_Mitigated"=>0,
    #  "Damage_Player"=>53716,
    #  "Damage_Taken"=>26416,
    #  "Damage_Taken_Magical"=>0,
    #  "Damage_Taken_Physical"=>26416,
    #  "Deaths"=>0,
    #  "Distance_Traveled"=>0,
    #  "Entry_Datetime"=>"6/22/2021 12:00:01 AM",
    #  "Final_Match_Level"=>0,
    #  "Gold_Earned"=>2631,
    #  "Gold_Per_Minute"=>315,
    #  "Healing"=>0,
    #  "Healing_Bot"=>0,
    #  "Healing_Player_Self"=>13348,
    #  "ItemId1"=>15063,
    #  "ItemId2"=>14457,
    #  "ItemId3"=>14426,
    #  "ItemId4"=>14454,
    #  "ItemId5"=>15062,
    #  "ItemId6"=>16431,
    #  "ItemLevel1"=>2,
    #  "ItemLevel2"=>4,
    #  "ItemLevel3"=>2,
    #  "ItemLevel4"=>3,
    #  "ItemLevel5"=>4,
    #  "ItemLevel6"=>0,
    #  "Item_Active_1"=>"Morale Boost",
    #  "Item_Active_2"=>"Cauterize",
    #  "Item_Active_3"=>"Haven",
    #  "Item_Active_4"=>"Life Rip",
    #  "Item_Purch_1"=>"Run and Gun",
    #  "Item_Purch_2"=>"Scramble",
    #  "Item_Purch_3"=>"Hot Potato",
    #  "Item_Purch_4"=>"Second Wind",
    #  "Item_Purch_5"=>"Guerrilla Warfare",
    #  "Item_Purch_6"=>"Cardio",
    #  "Killing_Spree"=>27,
    #  "Kills_Bot"=>0,
    #  "Kills_Double"=>0,
    #  "Kills_Fire_Giant"=>2,
    #  "Kills_First_Blood"=>0,
    #  "Kills_Gold_Fury"=>2,
    #  "Kills_Penta"=>0,
    #  "Kills_Phoenix"=>0,
    #  "Kills_Player"=>12,
    #  "Kills_Quadra"=>0,
    #  "Kills_Siege_Juggernaut"=>0,
    #  "Kills_Single"=>0,
    #  "Kills_Triple"=>0,
    #  "Kills_Wild_Juggernaut"=>1,
    #  "League_Losses"=>0,
    #  "League_Points"=>0,
    #  "League_Tier"=>0,
    #  "League_Wins"=>0,
    #  "Map_Game"=>"LIVE Ice Mines",
    #  "Mastery_Level"=>15,
    #  "Match"=>1101287959,
    #  "Match_Duration"=>473,
    #  "MergedPlayers"=>nil,
    #  "Minutes"=>8,
    #  "Multi_kill_Max"=>1,
    #  "Objective_Assists"=>91,
    #  "PartyId"=>2393639,
    #  "Platform"=>"XboxLive",
    #  "Rank_Stat_League"=>0,
    #  "Reference_Name"=>"Viktor",
    #  "Region"=>"NA",
    #  "Skin"=>"Soldier +",
    #  "SkinId"=>15177,
    #  "Structure_Damage"=>0,
    #  "Surrendered"=>0,
    #  "TaskForce"=>1,
    #  "Team1Score"=>4,
    #  "Team2Score"=>0,
    #  "TeamId"=>0,
    #  "Team_Name"=>"",
    #  "Time_In_Match_Seconds"=>501,
    #  "Towers_Destroyed"=>0,
    #  "Wards_Placed"=>0,
    #  "Win_Status"=>"Winner",
    #  "Winning_TaskForce"=>1,
    #  "hasReplay"=>"n",
    #  "hz_gamer_tag"=>nil,
    #  "hz_player_name"=>nil,
    #  "match_queue_id"=>424,
    #  "name"=>"Siege",
    #  "playerId"=>"702681625",
    #  "playerName"=>"Itz Swiizzyy",
    #  "playerPortalId"=>"10",
    #  "playerPortalUserId"=>"2533274893279609",
    #  "ret_msg"=>nil}
    payload = query(@api.get_match_details({ match_id: match_ids[0] }))
    assert_sized_array_of_hashes_with_keys(payload, 10,  %w{Account_Level ActiveId1 ActiveId2 ActiveId3 ActiveId4 ActiveLevel1 ActiveLevel2 ActiveLevel3 ActiveLevel4 ActivePlayerId Assists BanId1 BanId2 BanId3 BanId4 Ban_1 Ban_2 Ban_3 Ban_4 Camps_Cleared ChampionId Damage_Bot Damage_Done_In_Hand Damage_Done_Magical Damage_Done_Physical Damage_Mitigated Damage_Player Damage_Taken Damage_Taken_Magical Damage_Taken_Physical Deaths Distance_Traveled Entry_Datetime Final_Match_Level Gold_Earned Gold_Per_Minute Healing Healing_Bot Healing_Player_Self ItemId1 ItemId2 ItemId3 ItemId4 ItemId5 ItemId6 ItemLevel1 ItemLevel2 ItemLevel3 ItemLevel4 ItemLevel5 ItemLevel6 Item_Active_1 Item_Active_2 Item_Active_3 Item_Active_4 Item_Purch_1 Item_Purch_2 Item_Purch_3 Item_Purch_4 Item_Purch_5 Item_Purch_6 Killing_Spree Kills_Bot Kills_Double Kills_Fire_Giant Kills_First_Blood Kills_Gold_Fury Kills_Penta Kills_Phoenix Kills_Player Kills_Quadra Kills_Siege_Juggernaut Kills_Single Kills_Triple Kills_Wild_Juggernaut League_Losses League_Points League_Tier League_Wins Map_Game Mastery_Level Match Match_Duration MergedPlayers Minutes Multi_kill_Max Objective_Assists PartyId Platform Rank_Stat_League Reference_Name Region Skin SkinId Structure_Damage Surrendered TaskForce Team1Score Team2Score TeamId Team_Name Time_In_Match_Seconds Towers_Destroyed Wards_Placed Win_Status Winning_TaskForce hasReplay hz_gamer_tag hz_player_name match_queue_id name playerId playerName playerPortalId playerPortalUserId ret_msg})
  end

  # get_match_details_batch:                [nil,    -> { "#{boilerplate('getmatchdetailsbatch')}/#{match_ids.map(&:to_s).join(',')}" }, { match_ids: [9999,9998] }],
  def test_get_match_details_batch
    # {"Account_Level"=>38,
    #  "ActiveId1"=>12010,
    #  "ActiveId2"=>13235,
    #  "ActiveId3"=>11826,
    #  "ActiveId4"=>11797,
    #  "ActiveLevel1"=>2,
    #  "ActiveLevel2"=>1,
    #  "ActiveLevel3"=>0,
    #  "ActiveLevel4"=>1,
    #  "ActivePlayerId"=>"725993524",
    #  "Assists"=>19,
    #  "BanId1"=>0,
    #  "BanId2"=>0,
    #  "BanId3"=>0,
    #  "BanId4"=>0,
    #  "Ban_1"=>nil,
    #  "Ban_2"=>nil,
    #  "Ban_3"=>nil,
    #  "Ban_4"=>nil,
    #  "Camps_Cleared"=>0,
    #  "ChampionId"=>2528,
    #  "Damage_Bot"=>0,
    #  "Damage_Done_In_Hand"=>48597,
    #  "Damage_Done_Magical"=>0,
    #  "Damage_Done_Physical"=>52752,
    #  "Damage_Mitigated"=>7622,
    #  "Damage_Player"=>52752,
    #  "Damage_Taken"=>122347,
    #  "Damage_Taken_Magical"=>0,
    #  "Damage_Taken_Physical"=>122347,
    #  "Deaths"=>4,
    #  "Distance_Traveled"=>0,
    #  "Entry_Datetime"=>"6/22/2021 12:00:01 AM",
    #  "Final_Match_Level"=>0,
    #  "Gold_Earned"=>3532,
    #  "Gold_Per_Minute"=>332,
    #  "Healing"=>0,
    #  "Healing_Bot"=>0,
    #  "Healing_Player_Self"=>36295,
    #  "ItemId1"=>25000,
    #  "ItemId2"=>25006,
    #  "ItemId3"=>24988,
    #  "ItemId4"=>24997,
    #  "ItemId5"=>25003,
    #  "ItemId6"=>24778,
    #  "ItemLevel1"=>2,
    #  "ItemLevel2"=>1,
    #  "ItemLevel3"=>5,
    #  "ItemLevel4"=>4,
    #  "ItemLevel5"=>3,
    #  "ItemLevel6"=>0,
    #  "Item_Active_1"=>"Life Rip",
    #  "Item_Active_2"=>"Deft Hands",
    #  "Item_Active_3"=>"Nimble",
    #  "Item_Active_4"=>"Kill to Heal",
    #  "Item_Purch_1"=>"Fanning the Flames",
    #  "Item_Purch_2"=>"Subjugation",
    #  "Item_Purch_3"=>"Sinister Allies",
    #  "Item_Purch_4"=>"Desperation",
    #  "Item_Purch_5"=>"Shattered Essence",
    #  "Item_Purch_6"=>"Enforcer",
    #  "Killing_Spree"=>11,
    #  "Kills_Bot"=>0,
    #  "Kills_Double"=>0,
    #  "Kills_Fire_Giant"=>1,
    #  "Kills_First_Blood"=>0,
    #  "Kills_Gold_Fury"=>2,
    #  "Kills_Penta"=>0,
    #  "Kills_Phoenix"=>0,
    #  "Kills_Player"=>5,
    #  "Kills_Quadra"=>0,
    #  "Kills_Siege_Juggernaut"=>0,
    #  "Kills_Single"=>0,
    #  "Kills_Triple"=>0,
    #  "Kills_Wild_Juggernaut"=>1,
    #  "League_Losses"=>0,
    #  "League_Points"=>0,
    #  "League_Tier"=>0,
    #  "League_Wins"=>0,
    #  "Map_Game"=>"LIVE Bazaar",
    #  "Mastery_Level"=>18,
    #  "Match"=>1101287960,
    #  "Match_Duration"=>613,
    #  "MergedPlayers"=>nil,
    #  "Minutes"=>10,
    #  "Multi_kill_Max"=>1,
    #  "Objective_Assists"=>166,
    #  "PartyId"=>2319996,
    #  "Platform"=>"Steam",
    #  "Rank_Stat_League"=>0,
    #  "Reference_Name"=>"Raum",
    #  "Region"=>"NA",
    #  "Skin"=>"Default Raum",
    #  "SkinId"=>24900,
    #  "Structure_Damage"=>0,
    #  "Surrendered"=>0,
    #  "TaskForce"=>2,
    #  "Team1Score"=>1,
    #  "Team2Score"=>4,
    #  "TeamId"=>0,
    #  "Team_Name"=>"",
    #  "Time_In_Match_Seconds"=>637,
    #  "Towers_Destroyed"=>0,
    #  "Wards_Placed"=>0,
    #  "Win_Status"=>"Winner",
    #  "Winning_TaskForce"=>2,
    #  "hasReplay"=>"n",
    #  "hz_gamer_tag"=>nil,
    #  "hz_player_name"=>nil,
    #  "match_queue_id"=>424,
    #  "name"=>"Siege",
    #  "playerId"=>"725993524",
    #  "playerName"=>"KingoftheCob",
    #  "playerPortalId"=>"5",
    #  "playerPortalUserId"=>"76561198809388055",
    #  "ret_msg"=>nil}
    payload = query(@api.get_match_details_batch({ match_ids: match_ids[1,2] }))
    assert_sized_array_of_hashes_with_keys(payload, 20, %w{Account_Level ActiveId1 ActiveId2 ActiveId3 ActiveId4 ActiveLevel1 ActiveLevel2 ActiveLevel3 ActiveLevel4 ActivePlayerId Assists BanId1 BanId2 BanId3 BanId4 Ban_1 Ban_2 Ban_3 Ban_4 Camps_Cleared ChampionId Damage_Bot Damage_Done_In_Hand Damage_Done_Magical Damage_Done_Physical Damage_Mitigated Damage_Player Damage_Taken Damage_Taken_Magical Damage_Taken_Physical Deaths Distance_Traveled Entry_Datetime Final_Match_Level Gold_Earned Gold_Per_Minute Healing Healing_Bot Healing_Player_Self ItemId1 ItemId2 ItemId3 ItemId4 ItemId5 ItemId6 ItemLevel1 ItemLevel2 ItemLevel3 ItemLevel4 ItemLevel5 ItemLevel6 Item_Active_1 Item_Active_2 Item_Active_3 Item_Active_4 Item_Purch_1 Item_Purch_2 Item_Purch_3 Item_Purch_4 Item_Purch_5 Item_Purch_6 Killing_Spree Kills_Bot Kills_Double Kills_Fire_Giant Kills_First_Blood Kills_Gold_Fury Kills_Penta Kills_Phoenix Kills_Player Kills_Quadra Kills_Siege_Juggernaut Kills_Single Kills_Triple Kills_Wild_Juggernaut League_Losses League_Points League_Tier League_Wins Map_Game Mastery_Level Match Match_Duration MergedPlayers Minutes Multi_kill_Max Objective_Assists PartyId Platform Rank_Stat_League Reference_Name Region Skin SkinId Structure_Damage Surrendered TaskForce Team1Score Team2Score TeamId Team_Name Time_In_Match_Seconds Towers_Destroyed Wards_Placed Win_Status Winning_TaskForce hasReplay hz_gamer_tag hz_player_name match_queue_id name playerId playerName playerPortalId playerPortalUserId ret_msg})
  end
  # get_match_ids_by_queue:                 [nil,    -> { "#{boilerplate('getmatchidsbyqueue')}/#{queue_id}/#{date}/#{hour}" }, { queue_id: 424 }],
  def test_get_match_ids_by_queue
    #{"Active_Flag"=>"n",
    #  "Entry_Datetime"=>"6/22/2021 12:00:01 AM",
    #  "Match"=>"1101287959",
    #  "ret_msg"=>nil}
    payload = query(@api.get_match_ids_by_queue({ queue_id: Smiten::QueueCode[:live_siege], date: '20210622', hour: '0,00' }))
    assert_sized_array_of_hashes_with_keys(payload, "100+", %w{Active_Flag Entry_Datetime Match ret_msg})
  end
  # get_match_player_details:               [nil,    -> { "#{boilerplate('getmatchplayerdetails')}/#{match_id}" }, { match_id: 9999 }],
  def test_get_match_player_details
    # We need a live match for this to work
    # {"Account_Champions_Played"=>0,
    #  "Account_Level"=>0,
    #  "ChampionId"=>0,
    #  "ChampionLevel"=>0,
    #  "ChampionName"=>nil,
    #  "Mastery_Level"=>0,
    #  "Match"=>0,
    #  "Queue"=>nil,
    #  "Skin"=>nil,
    #  "SkinId"=>0,
    #  "Tier"=>0,
    #  "mapGame"=>nil,
    #  "playerCreated"=>nil,
    #  "playerId"=>nil,
    #  "playerName"=>nil,
    #  "playerPortalId"=>nil,
    #  "playerPortalUserId"=>nil,
    #  "playerRegion"=>nil,
    #  "ret_msg"=>
    #   "No match_queue returned.  It is likely that the match wasn't live when GetMatchPlayerDetails() was called.",
    #  "taskForce"=>0,
    #  "tierLosses"=>0,
    #  "tierWins"=>0}
    # {"Account_Champions_Played"=>0,
    #  "Account_Level"=>0,
    #  "ChampionId"=>0,
    #  "ChampionLevel"=>0,
    #  "ChampionName"=>nil,
    #  "Mastery_Level"=>0,
    #  "Match"=>0,
    #  "Queue"=>nil,
    #  "Skin"=>nil,
    #  "SkinId"=>0,
    #  "Tier"=>0,
    #  "mapGame"=>nil,
    #  "playerCreated"=>nil,
    #  "playerId"=>nil,
    #  "playerName"=>nil,
    #  "playerPortalId"=>nil,
    #  "playerPortalUserId"=>nil,
    #  "playerRegion"=>nil,
    #  "ret_msg"=>
    #   "No match_queue returned.  It is likely that the match wasn't live when GetMatchPlayerDetails() was called.",
    #  "taskForce"=>0,
    #  "tierLosses"=>0,
    #  "tierWins"=>0}
    payload = query(@api.get_match_player_details({ match_id: match_ids[0] }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Account_Champions_Played Account_Level ChampionId ChampionLevel ChampionName Mastery_Level Match Queue Skin SkinId Tier mapGame playerCreated playerId playerName playerPortalId playerPortalUserId playerRegion ret_msg taskForce tierLosses tierWins})
  end
  # get_top_matches:                        [nil,    -> { "#{boilerplate('gettopmatches')}" }, {}],
  def test_get_top_matches
    payload = query(@api.get_top_matches)
    assert_instance_of(Array, payload)
    # TODO: This either times out or is an empty array.
  end
  # get_league_leaderboard:                 [nil,    -> { "#{boilerplate('getleagueleaderboard')}/#{queue_id}/#{tier}/#{round}" }, { queue_id: 424, tier: 9999, round: 9999 }],
  def test_get_league_leaderboard
    # {"Leaves"=>3,
    #  "Losses"=>59,
    #  "Name"=>"Penguinspwn87",
    #  "Points"=>99,
    #  "PrevRank"=>1000,
    #  "Rank"=>1,
    #  "Season"=>3,
    #  "Tier"=>0,
    #  "Trend"=>0,
    #  "Wins"=>36,
    #  "player_id"=>"721752082",
    #  "ret_msg"=>nil}
    payload = query(@api.get_league_leaderboard(queue_id: Smiten::QueueCode[:live_competitive_gamepad], tier: 1, round: 3))
    assert_sized_array_of_hashes_with_keys(payload, "15+", %w{Leaves Losses Name Points PrevRank Rank Season Tier Trend Wins player_id ret_msg})
  end
  # get_league_seasons:                     [nil,    -> { "#{boilerplate('getleagueseasons')}/{queue_id}" }, { queue_id: 424 }],
  def test_get_league_seasons
    # {"complete"=>true,
    #  "id"=>1,
    #  "league_description"=>"Ranked",
    #  "name"=>"Season 1",
    #  "ret_msg"=>nil,
    #  "round"=>3,
    #  "season"=>1}
    payload = query(@api.get_league_seasons({ queue_id: Smiten::QueueCode[:live_competitive_gamepad] }))
    assert_sized_array_of_hashes_with_keys(payload, "15+", %w{complete id league_description name ret_msg round season})
  end
  # get_team_details:                       [nil,    -> { "#{boilerplate('getteamdetails')}/#{team_id}" }, { team_id: 9999 }],
  def test_get_team_details
    payload = query(@api.get_team_details({ team_id: 479 }))
    assert_instance_of(Array, payload)
    # TODO: Investigate these team APIs as this returns an empty array
  end
  # get_team_players:                       [nil,    -> { "#{boilerplate('getteamplayers')}/#{team_id}" }, { team_id: 9999 }],
  def test_get_team_players
    payload = query(@api.get_team_players({ team_id: 115 }))
    assert_instance_of(Array, payload)
    # TODO: Investigate these team APIs as this returns an empty array
  end
  # get_esports_proleague_details:          [nil,    -> { "#{boilerplate('getesportsproleaguedetails')}" }, {}],
  def test_get_esports_proleague_details
    # {"away_team_clan_id"=>114,
    #  "away_team_name"=>"Flashpoint",
    #  "away_team_tagname"=>"FP",
    #  "home_team_clan_id"=>115,
    #  "home_team_name"=>"Elevate",
    #  "home_team_tagname"=>"ELV",
    #  "map_instance_id"=>"0",
    #  "match_date"=>"11/16/2018 11:00:00 PM",
    #  "match_number"=>"1",
    #  "match_status"=>"not-started",
    #  "matchup_id"=>"1604",
    #  "region"=>"NA",
    #  "ret_msg"=>nil,
    #  "tournament_name"=>"PCWC Dreamhack",
    #  "winning_team_clan_id"=>0}
    payload = query(@api.get_esports_proleague_details({ }))
    assert_sized_array_of_hashes_with_keys(payload, "10+", %w{away_team_clan_id away_team_name away_team_tagname home_team_clan_id home_team_name home_team_tagname map_instance_id match_date match_number match_status matchup_id region ret_msg tournament_name winning_team_clan_id})
  end
  # get_motd:                               [nil,    -> { "#{boilerplate('getmotd')}"}, {} ]
  def test_get_motd
    #payload = query(@api.get_motd)
    #assert_instance_of(Array, payload)
    # TODO: why does this just give a missing endpoint exception?
  end

  def test_that_it_has_a_version_number
    refute_nil ::Smiten::VERSION
  end
end
