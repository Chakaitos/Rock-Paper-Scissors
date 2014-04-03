module RPS
  class SignIn < UseCase
    def run(input)
      user = DB.get_user_by_name(inputs[:name])
      return failure(:invalid_name) if RPS.db.get_user_by_name(name) != nil

      password = inputs[:password]
      return failure(:invalid_password) if get_user(name) != nil
    end
  end
end
