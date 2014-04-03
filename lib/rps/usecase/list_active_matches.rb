module RPS
  class ListActiveMatches < UseCase
    def run(inputs)
      @db = RPS.db 
      session = @db.get_session(inputs[:session_id])
      return failure(:no_session_found) if session.nil?

      user_id = @db.get_user_by_session(inputs[:session_id])
      matches = @db.matches.values.select {|x| x.winner == nil && (x.player1.id.to_i == user_id.to_i || x.player2.id.to_i == user_id.to_i)}
      return failure (:no_active_matches_for_user) if matches.count == 0

      success :matches => matches
    end
  end
end