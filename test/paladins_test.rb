# frozen_string_literal: true

require "test_helper"

class PaladinsTest < Minitest::Test
  include Smiten::Test::Common

  def setup
    creds = YAML.load_file(__dir__ + '/../.creds')
    @api = Smiten::Paladins.new(creds)
  end
  # getchampions:                ['Champion',     -> { "#{boilerplate('getchampions')}/#{language_code}" }, {}],
  def test_get_champions
    # {"Ability1"=>"Revolver",
    #  "Ability2"=>"Defiance",
    #  "Ability3"=>"Reversal",
    #  "Ability4"=>"Nether Step",
    #  "Ability5"=>"Accursed Arm",
    #  "AbilityId1"=>12489,
    #  "AbilityId2"=>13324,
    #  "AbilityId3"=>13251,
    #  "AbilityId4"=>12658,
    #  "AbilityId5"=>13254,
    #  "Ability_1"=>
    #   {"Description"=>
    #     "A cursed semi-automatic revolver that deals 520 damage every 0.36s. Has a maximum Ammo count of 6 and is fully effective up to 50 units.",
    #    "Id"=>12489,
    #    "Summary"=>"Revolver",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/paladins/champion-abilities/revolver.jpg",
    #    "damageType"=>"Direct",
    #    "rechargeSeconds"=>0},
    #  "Ability_2"=>
    #   {"Description"=>
    #     "Punch forward, striking enemies in front of you. Deals 520 damage and is fully effective up to 25 units.",
    #    "Id"=>13324,
    #    "Summary"=>"Defiance",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/paladins/champion-abilities/defiance.jpg",
    #    "damageType"=>"AoE",
    #    "rechargeSeconds"=>0},
    #  "Ability_3"=>
    #   {"Description"=>
    #     "Absorb enemy ranged attacks in front of you. After 1.4s, launch a blast that deals 75% of the damage you Absorbed.",
    #    "Id"=>13251,
    #    "Summary"=>"Reversal",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/paladins/champion-abilities/reversal.jpg",
    #    "damageType"=>"Direct",
    #    "rechargeSeconds"=>14},
    #  "Ability_4"=>
    #   {"Description"=>
    #     "Quickly dash in any direction up to 3 times before needing to recharge. Holding <CMD=GBA_Jump> reduces your fall speed in the air. Has a range of 31.5 units.",
    #    "Id"=>12658,
    #    "Summary"=>"Nether Step",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/paladins/champion-abilities/nether-step.jpg",
    #    "damageType"=>"True",
    #    "rechargeSeconds"=>10},
    #  "Ability_5"=>
    #   {"Description"=>
    #     "Take flight for 4s and mutate your Revolver. Your mutated Revolver shoots every 0.5s and deals 1000 damage in a 15-unit-radius area. Using this ability consumes 40% of your Ultimate charge and each shot consumes an additional 15%. This Revolver has a maximum Ammo count of 4 and a range of 400 units. Can be refired to cancel.",
    #    "Id"=>13254,
    #    "Summary"=>"Accursed Arm",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/paladins/champion-abilities/accursed-arm.jpg",
    #    "damageType"=>"AoE",
    #    "rechargeSeconds"=>0},
    #  "ChampionAbility1_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-abilities/revolver.jpg",
    #  "ChampionAbility2_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-abilities/defiance.jpg",
    #  "ChampionAbility3_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-abilities/reversal.jpg",
    #  "ChampionAbility4_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-abilities/nether-step.jpg",
    #  "ChampionAbility5_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-abilities/accursed-arm.jpg",
    #  "ChampionCard_URL"=>"",
    #  "ChampionIcon_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-icons/androxus.jpg",
    #  "Cons"=>"",
    #  "Health"=>2100,
    #  "Lore"=>
    #   "Androxus was once a noble lawman of the Outer Tribunal circuit judges. He and his former partner, Lex, were relentless in their pursuit of criminals and threats to the natural order. After a tragic confrontation with a deceitful being claiming to be a goddess, he became afflicted with an otherworldly disease, dooming him with an endless hunger for souls. Now he wanders the realm, adrift, in a never-ending quest to quell that hunger, stripped of his rank and duties with the Tribunal, and condemned to live with the curse for eternity.",
    #  "Name"=>"Androxus",
    #  "Name_English"=>"Androxus",
    #  "OnFreeRotation"=>"",
    #  "OnFreeWeeklyRotation"=>"",
    #  "Pantheon"=>"Norse",
    #  "Pros"=>"",
    #  "Roles"=>"Paladins Flanker",
    #  "Speed"=>365,
    #  "Title"=>"The Godslayer",
    #  "Type"=>"",
    #  "abilityDescription1"=>
    #   "A cursed semi-automatic revolver that deals 520 damage every 0.36s. Has a maximum Ammo count of 6 and is fully effective up to 50 units.",
    #  "abilityDescription2"=>
    #   "Punch forward, striking enemies in front of you. Deals 520 damage and is fully effective up to 25 units.",
    #  "abilityDescription3"=>
    #   "Absorb enemy ranged attacks in front of you. After 1.4s, launch a blast that deals 75% of the damage you Absorbed.",
    #  "abilityDescription4"=>
    #   "Quickly dash in any direction up to 3 times before needing to recharge. Holding <CMD=GBA_Jump> reduces your fall speed in the air. Has a range of 31.5 units.",
    #  "abilityDescription5"=>
    #   "Take flight for 4s and mutate your Revolver. Your mutated Revolver shoots every 0.5s and deals 1000 damage in a 15-unit-radius area. Using this ability consumes 40% of your Ultimate charge and each shot consumes an additional 15%. This Revolver has a maximum Ammo count of 4 and a range of 400 units. Can be refired to cancel.",
    #  "id"=>2205,
    #  "latestChampion"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.get_champions({}))
    assert_sized_array_of_hashes_with_keys(payload, 49, %w{Ability1 Ability2 Ability3 Ability4 Ability5 AbilityId1 AbilityId2 AbilityId3 AbilityId4 AbilityId5 Ability_1 Ability_2 Ability_3 Ability_4 Ability_5 ChampionAbility1_URL ChampionAbility2_URL ChampionAbility3_URL ChampionAbility4_URL ChampionAbility5_URL ChampionCard_URL ChampionIcon_URL Cons Health Lore Name Name_English OnFreeRotation OnFreeWeeklyRotation Pantheon Pros Roles Speed Title Type abilityDescription1 abilityDescription2 abilityDescription3 abilityDescription4 abilityDescription5 id latestChampion ret_msg})
  end
  # getchampioncards:            ['ChampionCard', -> { "#{boilerplate('getchampioncards')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
  def test_get_champion_cards
    #  {"active_flag_activation_schedule"=>"y",
    #  "active_flag_lti"=>"y",
    #  "card_description"=>
    #   "[Weapon] Reduce the Cooldown of Healing Potion by {scale=0.1|0.1}s after hitting an enemy with your weapon.",
    #  "card_id1"=>18808,
    #  "card_id2"=>12668,
    #  "card_name"=>"Acrobat's Trick",
    #  "card_name_english"=>"Acrobat's Trick",
    #  "championCard_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-cards/acrobats-trick.jpg",
    #  "championIcon_URL"=>
    #   "https://webcdn.hirezstudios.com/paladins/champion-icons/pip.jpg",
    #  "championTalent_URL"=>nil,
    #  "champion_id"=>2056,
    #  "champion_name"=>"Pip",
    #  "exclusive"=>"n",
    #  "rank"=>1,
    #  "rarity"=>"Common",
    #  "recharge_seconds"=>0,
    #  "ret_msg"=>nil}
    payload = query(@api.get_champion_cards({champion_id: 2056}))
    assert_sized_array_of_hashes_with_keys(payload, 19, %w{active_flag_activation_schedule active_flag_lti card_description card_id1 card_id2 card_name card_name_english championCard_URL championIcon_URL championTalent_URL champion_id champion_name exclusive rank rarity recharge_seconds ret_msg})
  end
  # getchampionskins:            ['ChampionSkin', -> { "#{boilerplate('getchampionskins')}/#{champion_id}/#{language_code}" }, {champion_id: 2056}],
  def test_get_champion_skins
    # {"champion_id"=>2056,
    #  "champion_name"=>"Pip",
    #  "rarity"=>"Rare",
    #  "ret_msg"=>nil,
    #  "skin_id1"=>52255,
    #  "skin_id2"=>20156,
    #  "skin_name"=>"Arctic",
    #  "skin_name_english"=>"Arctic"}
    payload = query(@api.get_champion_skins({champion_id: 2056}))
    assert_sized_array_of_hashes_with_keys(payload, 11, %w{champion_id champion_name rarity ret_msg skin_id1 skin_id2 skin_name skin_name_english})
  end
  # getchampionleaderboard:      [nil,            -> { "#{boilerplate('getchampionleaderboard')}/#{champion_id}/#{queue_id}" }, {champion_id: 2056, queue_id: 424}],
  def test_get_champion_leaderboard
    # only queue 428
    # {"champion_id"=>"2056",
    #  "losses"=>"49",
    #  "player_id"=>"505648429",
    #  "player_name"=>"",
    #  "player_ranking"=>"82.373299",
    #  "rank"=>"1",
    #  "ret_msg"=>nil,
    #  "wins"=>"97"}
    payload = query(@api.get_champion_leaderboard({ champion_id: 2056, queue_id: Smiten::QueueCode[:live_competitive_gamepad] }))
    assert_sized_array_of_hashes_with_keys(payload, 100, %w{champion_id losses player_id player_name player_ranking rank ret_msg wins})
  end
  # getchampionranks:            [nil,            -> { "#{boilerplate('getchampionranks')}/#{champion_id}" }, {champion_id: 2056}],
  def test_get_champion_ranks
    # {"Assists"=>1899,
    #  "Deaths"=>1125,
    #  "Gold"=>488712,
    #  "Kills"=>1652,
    #  "LastPlayed"=>"6/29/2021 6:24:36 PM",
    #  "Losses"=>89,
    #  "MinionKills"=>97,
    #  "Minutes"=>2058,
    #  "Rank"=>53,
    #  "Wins"=>82,
    #  "Worshippers"=>29457982,
    #  "champion"=>"Kinessa",
    #  "champion_id"=>"2249",
    #  "player_id"=>"720885066",
    #  "ret_msg"=>nil}
    payload = query(@api.get_champion_ranks({player_id: 720885066}))
    assert_instance_of(Array, payload)
    assert_sized_array_of_hashes_with_keys(payload, "45+", %w{Assists Deaths Gold Kills LastPlayed Losses MinionKills Minutes Rank Wins Worshippers champion champion_id player_id ret_msg})
  end
  # get_player_id_info_for_xbox_and_switch: [nil,    -> { "#{boilerplate('getplayeridinfoforxboxandswitch')}/#{player_name}" }, { player_name: 'conygred' }],
  def test_get_player_id_info_for_xbox_and_switch
    # {"Name"=>"",
    #  "gamer_tag"=>"conygred",
    #  "platform"=>"xbox",
    #  "player_id"=>"720885066",
    #  "portal_userid"=>2535432204002199,
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_id_info_for_xbox_and_switch({ player_name: 'conygred' }))
    assert_sized_array_of_hashes_with_keys(payload, 1, %w{Name gamer_tag platform player_id portal_userid ret_msg})
  end
  # get_player_loadouts:                    [nil,    -> { "#{boilerplate('getplayerloadouts')}/#{player_id}/#{language_code}" }, { player_id: 720885066 }],
  def test_get_player_loadouts
    # {"ChampionId"=>2205,
    #  "ChampionName"=>"Androxus",
    #  "DeckId"=>999320958,
    #  "DeckName"=>"New Loadout",
    #  "LoadoutItems"=>
    #   [{"ItemId"=>13319, "ItemName"=>"Power of the Abyss", "Points"=>2},
    #    {"ItemId"=>13293, "ItemName"=>"Elusive", "Points"=>1},
    #    {"ItemId"=>14810, "ItemName"=>"Abyssal Touch", "Points"=>3},
    #    {"ItemId"=>13399, "ItemName"=>"Equivalent Exchange", "Points"=>4},
    #    {"ItemId"=>11928, "ItemName"=>"Quick Draw", "Points"=>5}],
    #  "playerId"=>720885066,
    #  "playerName"=>"",
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_loadouts({ player_id: 720885066 }))
    assert_sized_array_of_hashes_with_keys(payload, "30+", %w{ChampionId ChampionName DeckId DeckName LoadoutItems playerId playerName ret_msg})
  end

end