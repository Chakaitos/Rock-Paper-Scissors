module RPS
  class PlayMove < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      match = @db.get_match(inputs[:match_id])

      return failure(:session_not_found) if session == nil
      return failure(:move_not_valid) if !(inputs[:move].downcase == "scissors" || inputs[:move].downcase == "paper" || inputs[:move].downcase == "rock")

      user_id = @db.get_user_by_session(inputs[:session_id])

      game = nil
      success :game => game, :match => match
    end
  end
end
