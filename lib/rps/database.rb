module RPS

	def self.db
		@__db_instance ||= DB.new
	end

	class DB
		# attr_reader :users, :matches, :games, :sessions
		attr_accessor :users, :matches, :games, :sessions
		def initialize
			@users = {}
			@matches = {}
			@games = {}
			@sessions = []
		end
		#USER CRUD
		def make_user(name)
			user = User.new(name)
			@users[user.id.to_i] = user
			user
		end

		def update_user(id,name)
		 	user = @users[id.to_i] 
			user.name = name
			user
		end

		def get_user(id)
			@users[id.to_i]
		end

		def delete_user(id)
			@users.delete(id.to_i)
			@users
		end

		def show_all_users
			@users

		end

		#MATCH CRUD
		def create_match(user1,user2)
			match = Match.new(user1,user2)
			@matches[match.id.to_i] = match
			match
		end

		def show_all_matches
			@matches
		end

		def get_match(id)
			@matches[id.to_i]
		end

		#GAME CRUD

		def start_game_in_match(choice1,choice2,mid)

		end


	end