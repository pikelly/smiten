module Smiten
  module Test
    module Common
      private

      def assert_sized_array_of_hashes_with_keys(payload, size, keys)
        assert_instance_of(Array, payload)
        if size.is_a?(String) && size[-1] == '+'
          assert payload.size >= size[0..-1].to_i
        else
          assert payload.size == size
        end
        assert payload[0].keys.sort == keys unless payload.empty?
      end

      def query(result)
        refute_empty(result)
        assert_instance_of(Hash, result)
        refute_nil result[:payload]
        result[:payload]
      end

      def player_info
        return @player_info if @player_info

        match_ids.each do |match_id|
          match_details = @api.get_match_details({ match_id: match_id })[:payload]
          match_details.each do |player|
            next if player['TeamId'] == 0

            @player_info = OpenStruct.new( id: player["ActivePlayerId"], match_id: match_id, party_id: player["PartyId"], platform: player['Platform'],
                                           team_id: player['TeamId'], hz_gamer_tag: player['hz_gamer_tag'], hz_player_name: player['hz_player_name'],
                                           match_queue_id: player['match_queue_id'], name: player['name'], player_name: player['playerName'],
                                           portal_id: player['playerPortalId'], player_portal_user_id: player['playerPortalUserId'])
            return
          end
        end
      end

      def match_ids
        @match_ids ||= @api.get_match_ids_by_queue({ queue_id: Smiten::QueueCode[:live_siege], date: '20210622', hour: '0,00' })[:payload].map {|match| match["Match"]}
      end

    end
  end
end