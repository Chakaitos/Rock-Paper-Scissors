module RPS
  class PlayMove < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      match = @db.get_match(inputs[:match_id])

      return failure(:session_not_found) if session == nil
      return failure(:move_not_valid) if (inputs[:move].downcase != "scissors" || inputs[:move].downcase != "paper" || inputs[:move].downcase != "rock")

      user_id = @db.get_user_by_session(inputs[:session_id])

      # game = nil
      # return failure(:match_complete) if match.winner
      # if (user_id == match.user1_id)
      #   match.user1_last_move = inputs[:move]
      #   if match.user2_last_move
      #     game = @db.create_game(match.id, inputs[:move], match.user2_last_move)
      #     match.user1_last_move = nil
      #     match.user2_last_move = nil
      #     match.winner = user_id if match.user1_score >= 3
      #     match.winner = match.user2_id if match.user2_score >= 3
      #   end
      # elsif (user_id == match.user2_id)
      #   match.user2_last_move = inputs[:move]
      #   # other_player_moved = true if match.user1_last_move
      #   if match.user1_last_move
      #     game = @db.create_game(match.id, match.user1_last_move, inputs[:move])
      #     match.user1_last_move = nil
      #     match.user2_last_move = nil
      #     match.winner = match.user1_id if match.user1_score >= 3
      #     match.winner = user_id if match.user2_score >= 3
      #   end
      # end
      success :game => game, :match => match
    end
  end
end
