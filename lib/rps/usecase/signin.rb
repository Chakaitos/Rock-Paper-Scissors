module RPS
  class SignUp < UseCase
    def run(input)
      username = inputs[:name]
      return failure(:name_taken) if RPS.db.get_user_by_name(username) != nil

      password = inputs[:password]
      return failure(:wrong_password) if get_user(username) != nil
    end
  end
end
