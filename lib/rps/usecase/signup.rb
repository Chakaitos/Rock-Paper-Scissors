module RPS
  class SignUp < UseCase
    def run(inputs)
    	@db = RPS.db
    	
      name = inputs[:name]
      return failure(:name_taken) if RPS.db.get_user_by_name(name) != nil
      password = inputs[:password]
      return failure(:weak_password) if password.length < 3

      user = @db.make_user(inputs[:name], inputs[:password])

      success :user => user
    end
  end
end


# NOTES FOR LATER
# x = UserCaseFailure.new({:error => :name_taken})
# x.error
# => :name_taken

#Inside Terminal Client class

# result = RPS::SignUp.run(stuff in here)

# if result.success?
#   # do stuff after sucessful sign up
# else
#   if result.error = :name_taken
#     puts "sorry, that username is taken"
#   elsif result.error = :wrong_password
#     puts "that password is invalid"
#   end
# end
