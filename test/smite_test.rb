# frozen_string_literal: true

require "test_helper"

class SmiteTest < Minitest::Test
  include Smiten::Test::Common

  def setup
    creds = YAML.load_file(__dir__ + '/../.creds')
    @api = Smiten::Smite.new(creds)
  end

  # get_gods:                  [ 'God',     -> { "#{boilerplate('getgods')}/#{language_code}"}],
  def test_get_gods
    # {"Ability1"=>"Shield of Achilles",
    #  "Ability2"=>"Radiant Glory",
    #  "Ability3"=>"Combat Dodge",
    #  "Ability4"=>"Fatal Strike",
    #  "Ability5"=>"Gift of the Gods",
    #  "AbilityId1"=>15676,
    #  "AbilityId2"=>15677,
    #  "AbilityId3"=>15679,
    #  "AbilityId4"=>15680,
    #  "AbilityId5"=>15678,
    #  "Ability_1"=>
    #   {"Description"=>
    #     {"itemDescription"=>
    #       {"cooldown"=>"14s",
    #        "cost"=>"60/65/70/75/80",
    #        "description"=>
    #         "Achilles punches forward with the edge of his Shield, inflicting massive damage and stunning enemy targets hit by the impact. The force of his punch continues to radiate past his initial target area, dealing 85% damage to targets farther away.",
    #        "menuitems"=>
    #         [{"description"=>"Ability:", "value"=>"Cone"},
    #          {"description"=>"Affects:", "value"=>"Enemies"},
    #          {"description"=>"Damage:", "value"=>"Physical"},
    #          {"description"=>"Range:", "value"=>"50"}],
    #        "rankitems"=>
    #         [{"description"=>"Damage:",
    #           "value"=>"100/155/210/265/320 (90% of your Physical Power)"},
    #          {"description"=>"Stun Duration:", "value"=>"1s"}]}},
    #    "Id"=>15676,
    #    "Summary"=>"Shield of Achilles",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/smite/god-abilities/shield-of-achilles.jpg"},
    #  "Ability_2"=>
    #   {"Description"=>
    #     {"itemDescription"=>
    #       {"cooldown"=>"10s",
    #        "cost"=>"40/45/50/55/60",
    #        "description"=>
    #         "Achilles is blessed by the gods, giving him bonus Physical Power, Protections, and Crowd Control Reduction for 6 seconds. While this blessing is active, Achilles will heal himself upon successfully damaging enemies with abilities.",
    #        "menuitems"=>
    #         [{"description"=>"Ability:", "value"=>"Buff"},
    #          {"description"=>"Affects:", "value"=>"Self"}],
    #        "rankitems"=>
    #         [{"description"=>"Heal:",
    #           "value"=>"20/23/26/29/32 (10% of your Physical Power)"},
    #          {"description"=>"Max Heals per Ability:", "value"=>"2/2/3/3/4"},
    #          {"description"=>"Physical Power:", "value"=>"+6/7/8/9/10%"},
    #          {"description"=>"Protections:", "value"=>"+10/12.5/15/17.5/20%"},
    #          {"description"=>"Crowd Control Reduction:", "value"=>"20%"}]}},
    #    "Id"=>15677,
    #    "Summary"=>"Radiant Glory",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/smite/god-abilities/radiant-glory.jpg"},
    #  "Ability_3"=>
    #   {"Description"=>
    #     {"itemDescription"=>
    #       {"cooldown"=>"14/13/12/11/10s",
    #        "cost"=>"24/28/32/36/40",
    #        "description"=>
    #         "Achilles dodges his enemies' attacks before striking them in swift response. If Achilles successfully hits an enemy god with this strike, Achilles can use this ability once more before it goes on Cooldown.",
    #        "menuitems"=>
    #         [{"description"=>"Ability:", "value"=>"Dash"},
    #          {"description"=>"Affects:", "value"=>"Enemies"},
    #          {"description"=>"Damage:", "value"=>"Physical"},
    #          {"description"=>"Range:", "value"=>"35"}],
    #        "rankitems"=>
    #         [{"description"=>"Damage:",
    #           "value"=>"50/85/120/155/190 (+45% of your Physical Power)"}]}},
    #    "Id"=>15679,
    #    "Summary"=>"Combat Dodge",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/smite/god-abilities/combat-dodge.jpg"},
    #  "Ability_4"=>
    #   {"Description"=>
    #     {"itemDescription"=>
    #       {"cooldown"=>"90s",
    #        "cost"=>"80/85/90/95/100",
    #        "description"=>
    #         "Achilles dashes forward and attacks. While dashing, Achilles will pass through minions, stop and hit the first enemy god he encounters, dealing damage to all he hits and executing gods below 30% Health. If Achilles kills a god with this ability, he can use it again, up to 5 times. As Achilles successfully Executes his enemies, he becomes more reckless in combat and leaves his heel exposed. Achilles will become more susceptible to damage, stacking up to 5 times.",
    #        "menuitems"=>
    #         [{"description"=>"Ability:", "value"=>"Dash"},
    #          {"description"=>"Affects:", "value"=>"Enemies"},
    #          {"description"=>"Damage:", "value"=>"Physical"},
    #          {"description"=>"Range:", "value"=>"35"}],
    #        "rankitems"=>
    #         [{"description"=>"Damage:",
    #           "value"=>"180/270/360/450/540 (100% of your Physical Power)"},
    #          {"description"=>"Execute Threshold:", "value"=>"30%"},
    #          {"description"=>"Damage Taken Increase:", "value"=>"5%"}]}},
    #    "Id"=>15680,
    #    "Summary"=>"Fatal Strike",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/smite/god-abilities/fatal-strike.jpg"},
    #  "Ability_5"=>
    #   {"Description"=>
    #     {"itemDescription"=>
    #       {"cooldown"=>"",
    #        "cost"=>"",
    #        "description"=>
    #         "Achilles adapts to the tide of Battle. While in the Fountain, Achilles can choose to wear armor, granting him bonus Health and Protections, or forgo it, granting him bonus Movement Speed and Physical Power. To swap, use Achilles' Basic Attack while the Passive targeter is active. ",
    #        "menuitems"=>[{"description"=>"Ability:", "value"=>"Passive"}],
    #        "rankitems"=>
    #         [{"description"=>"Health Bonus:", "value"=>"25 +15 per Level"},
    #          {"description"=>"Protections Bonus:", "value"=>"5 +2 per Level"},
    #          {"description"=>"Movement Speed Bonus:",
    #           "value"=>"1% +.25% per Level"},
    #          {"description"=>"Physical Power Bonus:",
    #           "value"=>"3 +2 per Level"}]}},
    #    "Id"=>15678,
    #    "Summary"=>"Gift of the Gods",
    #    "URL"=>
    #     "https://webcdn.hirezstudios.com/smite/god-abilities/gift-of-the-gods.jpg"},
    #  "AttackSpeed"=>0.95,
    #  "AttackSpeedPerLevel"=>0.012,
    #  "AutoBanned"=>"n",
    #  "Cons"=>"",
    #  "HP5PerLevel"=>0.75,
    #  "Health"=>475,
    #  "HealthPerFive"=>9,
    #  "HealthPerLevel"=>85,
    #  "Lore"=>
    #   "King Agamemnon brought his fury to bear against gilded Troy, for Prince Paris had stolen his Helen, his wife, whose beauty rivaled that of Athena and Aphrodite. To famed Achilles, invincible warrior, the king gave command of a thousand ships.\\n\\nAcross stormy seas and salted beach, soldiers sieged the city. Arrow and stone, blade and barb bounced from Achilles’ skin. Bathed as a babe in the River Styx by his Nereid mother, his hide was hardened, imperviously made. Through every charge, every death-defying battle, Achilles was at the fore. Troy hung poised to crumble.\\n\\nUntil Agamemnon gave slight to the mighty myrmidon. In grave offense, Achilles pulled his forces from the field. Hector, boldest, bravest, eldest of the Trojan princes seized the chance to push the Greeks to the sea. Water’s reflection mirrored scorching sails as Hector fired their ships. All seemed lost until Achilles rose to meet him. Fierce and fast the two titans fought, but Hector’s spear felled Achilles fair. Though Patroclus, it was, in the armor of Achilles, not Achilles who lay dead.\\n\\nWrathful at the loss of his faithful lover, Achilles donned armor newly-made and challenged Hector alone. Spear and blade and amor rang, but Achilles could not be harmed. Hector, prince of Troy, died in battle that day.\\n\\nParis, brother lost, tearful-eyed, let arrow loose, guided by divine envy. For there were Gods that could not suffer Achilles to survive. Straight and true the arrow flew and harpooned Achilles’ heel, where his mother held him when submerged. The wound was deep, his weakness found, Achilles met his end.\\n\\nA decade thence, from Hades’ depths, Achilles has been drawn. Armored now, upon the heel, revenge his only aim. For envious Gods stole from him his glory and his life. Now they tremble at the wrath of the man who cannot be harmed.",
    #  "MP5PerLevel"=>0.39,
    #  "MagicProtection"=>30,
    #  "MagicProtectionPerLevel"=>0.9,
    #  "MagicalPower"=>0,
    #  "MagicalPowerPerLevel"=>0,
    #  "Mana"=>205,
    #  "ManaPerFive"=>4.7,
    #  "ManaPerLevel"=>35,
    #  "Name"=>"Achilles",
    #  "OnFreeRotation"=>"",
    #  "Pantheon"=>"Greek",
    #  "PhysicalPower"=>38,
    #  "PhysicalPowerPerLevel"=>2,
    #  "PhysicalProtection"=>17,
    #  "PhysicalProtectionPerLevel"=>3,
    #  "Pros"=>"High Single Target Damage, High Mobility",
    #  "Roles"=>"Warrior",
    #  "Speed"=>370,
    #  "Title"=>"Hero of the Trojan War",
    #  "Type"=>"Melee, Physical",
    #  "abilityDescription1"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"14s",
    #      "cost"=>"60/65/70/75/80",
    #      "description"=>
    #       "Achilles punches forward with the edge of his Shield, inflicting massive damage and stunning enemy targets hit by the impact. The force of his punch continues to radiate past his initial target area, dealing 85% damage to targets farther away.",
    #      "menuitems"=>
    #       [{"description"=>"Ability:", "value"=>"Cone"},
    #        {"description"=>"Affects:", "value"=>"Enemies"},
    #        {"description"=>"Damage:", "value"=>"Physical"},
    #        {"description"=>"Range:", "value"=>"50"}],
    #      "rankitems"=>
    #       [{"description"=>"Damage:",
    #         "value"=>"100/155/210/265/320 (90% of your Physical Power)"},
    #        {"description"=>"Stun Duration:", "value"=>"1s"}]}},
    #  "abilityDescription2"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"10s",
    #      "cost"=>"40/45/50/55/60",
    #      "description"=>
    #       "Achilles is blessed by the gods, giving him bonus Physical Power, Protections, and Crowd Control Reduction for 6 seconds. While this blessing is active, Achilles will heal himself upon successfully damaging enemies with abilities.",
    #      "menuitems"=>
    #       [{"description"=>"Ability:", "value"=>"Buff"},
    #        {"description"=>"Affects:", "value"=>"Self"}],
    #      "rankitems"=>
    #       [{"description"=>"Heal:",
    #         "value"=>"20/23/26/29/32 (10% of your Physical Power)"},
    #        {"description"=>"Max Heals per Ability:", "value"=>"2/2/3/3/4"},
    #        {"description"=>"Physical Power:", "value"=>"+6/7/8/9/10%"},
    #        {"description"=>"Protections:", "value"=>"+10/12.5/15/17.5/20%"},
    #        {"description"=>"Crowd Control Reduction:", "value"=>"20%"}]}},
    #  "abilityDescription3"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"14/13/12/11/10s",
    #      "cost"=>"24/28/32/36/40",
    #      "description"=>
    #       "Achilles dodges his enemies' attacks before striking them in swift response. If Achilles successfully hits an enemy god with this strike, Achilles can use this ability once more before it goes on Cooldown.",
    #      "menuitems"=>
    #       [{"description"=>"Ability:", "value"=>"Dash"},
    #        {"description"=>"Affects:", "value"=>"Enemies"},
    #        {"description"=>"Damage:", "value"=>"Physical"},
    #        {"description"=>"Range:", "value"=>"35"}],
    #      "rankitems"=>
    #       [{"description"=>"Damage:",
    #         "value"=>"50/85/120/155/190 (+45% of your Physical Power)"}]}},
    #  "abilityDescription4"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"90s",
    #      "cost"=>"80/85/90/95/100",
    #      "description"=>
    #       "Achilles dashes forward and attacks. While dashing, Achilles will pass through minions, stop and hit the first enemy god he encounters, dealing damage to all he hits and executing gods below 30% Health. If Achilles kills a god with this ability, he can use it again, up to 5 times. As Achilles successfully Executes his enemies, he becomes more reckless in combat and leaves his heel exposed. Achilles will become more susceptible to damage, stacking up to 5 times.",
    #      "menuitems"=>
    #       [{"description"=>"Ability:", "value"=>"Dash"},
    #        {"description"=>"Affects:", "value"=>"Enemies"},
    #        {"description"=>"Damage:", "value"=>"Physical"},
    #        {"description"=>"Range:", "value"=>"35"}],
    #      "rankitems"=>
    #       [{"description"=>"Damage:",
    #         "value"=>"180/270/360/450/540 (100% of your Physical Power)"},
    #        {"description"=>"Execute Threshold:", "value"=>"30%"},
    #        {"description"=>"Damage Taken Increase:", "value"=>"5%"}]}},
    #  "abilityDescription5"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"",
    #      "cost"=>"",
    #      "description"=>
    #       "Achilles adapts to the tide of Battle. While in the Fountain, Achilles can choose to wear armor, granting him bonus Health and Protections, or forgo it, granting him bonus Movement Speed and Physical Power. To swap, use Achilles' Basic Attack while the Passive targeter is active. ",
    #      "menuitems"=>[{"description"=>"Ability:", "value"=>"Passive"}],
    #      "rankitems"=>
    #       [{"description"=>"Health Bonus:", "value"=>"25 +15 per Level"},
    #        {"description"=>"Protections Bonus:", "value"=>"5 +2 per Level"},
    #        {"description"=>"Movement Speed Bonus:", "value"=>"1% +.25% per Level"},
    #        {"description"=>"Physical Power Bonus:", "value"=>"3 +2 per Level"}]}},
    #  "basicAttack"=>
    #   {"itemDescription"=>
    #     {"cooldown"=>"",
    #      "cost"=>"",
    #      "description"=>"",
    #      "menuitems"=>
    #       [{"description"=>"Damage:",
    #         "value"=>"38 + 2/Lvl (+100% of Physical Power)"},
    #        {"description"=>"Progression:", "value"=>"None"}],
    #      "rankitems"=>[]}},
    #  "godAbility1_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-abilities/shield-of-achilles.jpg",
    #  "godAbility2_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-abilities/radiant-glory.jpg",
    #  "godAbility3_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-abilities/combat-dodge.jpg",
    #  "godAbility4_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-abilities/fatal-strike.jpg",
    #  "godAbility5_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-abilities/gift-of-the-gods.jpg",
    #  "godCard_URL"=>"https://webcdn.hirezstudios.com/smite/god-cards/achilles.jpg",
    #  "godIcon_URL"=>"https://webcdn.hirezstudios.com/smite/god-icons/achilles.jpg",
    #  "id"=>3492,
    #  "latestGod"=>"n",
    #  "ret_msg"=>nil}
    payload = query(@api.get_gods({}))
    assert_sized_array_of_hashes_with_keys(payload, 115, %w{Ability1 Ability2 Ability3 Ability4 Ability5 AbilityId1 AbilityId2 AbilityId3 AbilityId4 AbilityId5 Ability_1 Ability_2 Ability_3 Ability_4 Ability_5 AttackSpeed AttackSpeedPerLevel AutoBanned Cons HP5PerLevel Health HealthPerFive HealthPerLevel Lore MP5PerLevel MagicProtection MagicProtectionPerLevel MagicalPower MagicalPowerPerLevel Mana ManaPerFive ManaPerLevel Name OnFreeRotation Pantheon PhysicalPower PhysicalPowerPerLevel PhysicalProtection PhysicalProtectionPerLevel Pros Roles Speed Title Type abilityDescription1 abilityDescription2 abilityDescription3 abilityDescription4 abilityDescription5 basicAttack godAbility1_URL godAbility2_URL godAbility3_URL godAbility4_URL godAbility5_URL godCard_URL godIcon_URL id latestGod ret_msg})
  end
  # get_god_leaderboard:       [ nil,       -> { "#{boilerplate('getgodleaderboard')}/#{god_id}/#{queue_id}"}, {god_id: 3492, queue_id: QueueCode[:conquest]}],
  def test_get_god_leaderboard
    # only queues 440, 450, 451
    # {"god_id"=>"3492",
    #  "losses"=>"1",
    #  "player_id"=>"11618425",
    #  "player_name"=>"Orphanghost2",
    #  "player_ranking"=>"80.501236",
    #  "rank"=>"1",
    #  "ret_msg"=>nil,
    #  "wins"=>"14"}
    payload = query(@api.get_god_leaderboard({ god_id: 3492, queue_id: Smiten::QueueCode[:conquest_ranked] }))
    assert_sized_array_of_hashes_with_keys(payload, "90+", %w{god_id losses player_id player_name player_ranking rank ret_msg wins})
  end
  # get_god_skins:             [ 'GodSkin', -> { "#{boilerplate('getgodskins')}/#{god_id}/#{language_code}"}, {god_id: 3492}],
  def test_get_god_skins
    # {"godIcon_URL"=>"https://webcdn.hirezstudios.com/smite/god-icons/achilles.jpg",
    #  "godSkin_URL"=>
    #   "https://webcdn.hirezstudios.com/smite/god-skins/achilles_standard-achilles.jpg",
    #  "god_id"=>3492,
    #  "god_name"=>"Achilles",
    #  "obtainability"=>"Normal",
    #  "price_favor"=>5500,
    #  "price_gems"=>200,
    #  "ret_msg"=>nil,
    #  "skin_id1"=>36980,
    #  "skin_id2"=>15670,
    #  "skin_name"=>"Standard Achilles"}
    payload = query(@api.get_god_skins({ god_id: 3492 }))
    assert_sized_array_of_hashes_with_keys(payload, 13, %w{godIcon_URL godSkin_URL god_id god_name obtainability price_favor price_gems ret_msg skin_id1 skin_id2 skin_name})
  end
  # get_god_recommended_items: [ nil,       -> { "#{boilerplate('getgodrecommendeditems')}/#{god_id}/#{language_code}"}, {god_id: 3492}],
  def test_get_god_recommended_items
    # {"Category"=>"Consumable",
    #  "Item"=>"Ward",
    #  "Role"=>"Standard",
    #  "category_value_id"=>10779,
    #  "god_id"=>3492,
    #  "god_name"=>"Achilles",
    #  "icon_id"=>1992,
    #  "item_id"=>7668,
    #  "ret_msg"=>nil,
    #  "role_value_id"=>10770}
    payload = query(@api.get_god_recommended_items({ god_id: 3492 }))
    assert_sized_array_of_hashes_with_keys(payload, "114+", %w{Category Item Role category_value_id god_id god_name icon_id item_id ret_msg role_value_id})
  end
  # get_god_ranks:             [ nil,       -> { "#{boilerplate('getgodranks')}/#{god_id}"}, {god_id: 3492}],
  def test_get_god_ranks
    # {"Assists"=>792,
    #  "Deaths"=>561,
    #  "Kills"=>743,
    #  "Losses"=>59,
    #  "MinionKills"=>17765,
    #  "Rank"=>10,
    #  "Wins"=>64,
    #  "Worshippers"=>1765,
    #  "god"=>"King Arthur",
    #  "god_id"=>"3565",
    #  "player_id"=>"11618425",
    #  "ret_msg"=>nil}
    payload = query(@api.get_god_ranks({ player_id: 11618425 }))
    assert_sized_array_of_hashes_with_keys(payload, "114+", %w{Assists Deaths Kills Losses MinionKills Rank Wins Worshippers god god_id player_id ret_msg})
  end
  # get_player_achievements:                [nil,    -> { "#{boilerplate('getplayerachievements')}/#{player_id}" }, { player_id: 720885066 }],
  def test_get_player_achievements
    # {"AssistedKills"=>17575,
    #  "CampsCleared"=>0,
    #  "DivineSpree"=>0,
    #  "DoubleKills"=>0,
    #  "FireGiantKills"=>1059,
    #  "FirstBloods"=>0,
    #  "GodLikeSpree"=>0,
    #  "GoldFuryKills"=>1935,
    #  "Id"=>720885066,
    #  "ImmortalSpree"=>0,
    #  "KillingSpree"=>0,
    #  "MinionKills"=>1678,
    #  "Name"=>"conygred",
    #  "PentaKills"=>0,
    #  "PhoenixKills"=>77396,
    #  "PlayerKills"=>0,
    #  "QuadraKills"=>0,
    #  "RampageSpree"=>0,
    #  "ShutdownSpree"=>0,
    #  "SiegeJuggernautKills"=>0,
    #  "TowerKills"=>0,
    #  "TripleKills"=>0,
    #  "UnstoppableSpree"=>0,
    #  "WildJuggernautKills"=>1976,
    #  "ret_msg"=>nil}
    payload = query(@api.get_player_achievements({ player_id: 720885066 }))
    assert_instance_of Hash, payload
    assert payload.keys.sort == %w{AssistedKills CampsCleared Deaths DivineSpree DoubleKills FireGiantKills FirstBloods GodLikeSpree GoldFuryKills Id ImmortalSpree KillingSpree MinionKills Name PentaKills PhoenixKills PlayerKills QuadraKills RampageSpree ShutdownSpree SiegeJuggernautKills TowerKills TripleKills UnstoppableSpree WildJuggernautKills ret_msg}
  end
  # search_teams:                           [nil,    -> { "#{boilerplate('searchteams')}/#{search_string}" }, { search_string: 'hello' }],
  def test_search_teams
    # {"Founder"=>"Fqte",
    #  "Name"=>"Rest in peace",
    #  "Players"=>2,
    #  "Tag"=>"RIP",
    #  "TeamId"=>479,
    #  "ret_msg"=>nil}
    payload = query(@api.search_teams({ search_string: 'ace' }))
    assert_sized_array_of_hashes_with_keys(payload, "200+", %w{Founder Name Players Tag TeamId ret_msg})
  end


end