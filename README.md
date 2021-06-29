# Smiten

This Gem provides a Ruby interface to the Hirez Paladins and Smite APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smiten'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install smiten

## Usage

This gem implements the API described here: https://docs.google.com/document/d/1OFS-3ocSx-1Rvg4afAnEHlT3917MAK_6eJTR6rzr-BM/edit 

Note that session management is handled internally

To retrieve a list of champions

champions = Smiten:Paladins.new({developerId('xxx', authKey(''yyy').get_champions

The returned value is a hash with two keys: **:kind** and **:payload**. 

**:kind** refers to the Capitalized class name 
of the returned object, such as *Player* or *ChampionCard*. For most calls this is nil.

**:payload** may be a String, Hash or Array depending on the API

## Supported APIs

The arguments to the method should be provided in a hash using the keys shown below
- get_bounty_items
- get_champion_cards(champion_id, language_code)
- get_champion_leaderboard(champion_id, queue_id)
- get_champion_ranks(player_id)
- get_champions(language_code)
- get_champion_skins(champion_id, language_code)
- get_data_used()
- get_demo_details(match_id)
- get_esports_proleague_details()
- get_friends(player_id)
- get_god_leaderboard(god_id, queue_id)
- get_god_ranks(player_id)
- get_god_recommended_items(god_id, language_code)
- get_gods(language_code)
- get_god_skins(god_id, language_code)
- get_hirez_server_status()
- get_items(language_code)
- get_league_leaderboard(queue_id, tier, round)
- get_league_seasons(queue_id)
- get_match_details_batch(match_ids)
- get_match_details(match_id)
- get_match_history(player_id)
- get_match_ids_by_queue(queue_id, date, hour)
- get_match_player_details(match_id)
- get_motd()
- get_patch_info()
- get_player(player [,portal_id])
- get_player_batch(player_ids)
- get_player_achievements(player_id)
- get_player_id_by_name(player_name)
- get_player_id_by_portal_user_id(portal_id, portal_user_id)
- get_player_id_info_for_xbox_and_switch(player_name)
- get_player_ids_by_gamer_tag(portal_id, gamer_tag)
- get_player_loadouts(player_id, language_code)
- get_player_status(player_id)
- get_queue_stats(player_id, queue_id)
- get_team_details(team_id)
- get_team_players(team_id)
- get_top_matches()
- ping()
- search_players(search_string)
- search_teams(search_string)
- test_session()
        
## Helper methods
- for_champion(champion_id)
  
    This scopes the following call to that champion
  
    Smiten:Paladins.new({developerId('xxx', authKey(''yyy').get_champion_cards({champion_id: 55, language_code: Smiten::Language[:english]}) and
  
    Smiten:Paladins.new({developerId('xxx', authKey(''yyy').for_champion(55).get_champion_cards({language_code: Smiten::Language[:english]})

    are identical

- in_language(identifier)
  
    This scopes the following call to use the selected language
  
    Smiten:Paladins.new({developerId('xxx', authKey(''yyy').get_champion_cards({champion_id: 55, language_code: Smiten::Language[:english]}) and
  
    Smiten:Paladins.new({developerId('xxx', authKey(''yyy').in_language(:english).get_champion_cards({champion_id: 55}) and
  
    Smiten:Paladins.new({developerId('xxx', authKey(''yyy').in_language(1).get_champion_cards({champion_id: 55})

    are identical

- hi_rez | steam | ps4 | xbox| switch| discord | epic

  These methods set the portal_id on the Smiten connector

  Smiten:Paladins.new({developerId('xxx', authKey(''yyy').get_player({:portal_id: 10, player: 'a_name'}) and

  Smiten:Paladins.new({developerId('xxx', authKey(''yyy').xbox.get_player({player: 'a_name''}) 

  are identical

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pikelly/smiten. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pikelly/smiten/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

