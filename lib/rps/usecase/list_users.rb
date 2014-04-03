module RPS
  class ListUsers < UseCase
    def run(inputs)
      @db = RPS.db
      session = @db.get_session(inputs[:session_id])
      return failure(:no_session_found) if session.nil?

      success :users => @db.show_all_users
    end
  end
end