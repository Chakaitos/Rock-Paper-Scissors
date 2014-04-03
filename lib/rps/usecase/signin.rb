module RPS
  class SignIn < UseCase
    def run(inputs)
    	@db = RPS.db
    	
      user = @db.get_user_by_name(inputs[:name])
      return failure(:invalid_name) if user == nil
      password = inputs[:password]
      return failure(:invalid_password) if user.password != password

      session = @db.create_session(user.id)

      success :session_id => session.id, :user_id => user.id
    end
  end
end
