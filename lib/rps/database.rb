module RPS

	def self.db
		@__db_instance ||= DB.new
	end

	class DB
		# attr_reader :users, :matches, :games, :sessions
		attr_accessor :users, :matches, :games, :sessions, :invites
		def initialize
			@users = {}
			@matches = {}
			@games = {}
			@invites = {}
			@sessions = []
		end
		#USER CRUD
		def make_user(name, options={})
			user = User.new(name, options={})
			@users[user.id.to_i] = user
			user
		end

		def update_user(uid,name)
		 	user = @users[uid.to_i] 
			user.name = name
			user
		end

		def get_user(uid)
			@users[uid.to_i]
		end

		def delete_user(uid)
			@users.delete(uid.to_i)
			@users
		end

		def show_all_users
			@users.values
		end

		#MATCH CRUD
		def create_match(user1,user2)
			match = Match.new(user1,user2)
			@matches[match.id.to_i] = match
			match
		end

		def show_all_matches
			@matches.values
		end

		def get_match(mid)
			@matches[mid.to_i]
		end

		#GAME CRUD

		def create_game(mid)
			game = Game.new(mid)
			@games[game.id] = game
			game
		end

		def set_player1_choice(choice, gid)
			game	= @games.values.find {|x| x.id == gid.to_i}
			game.player1choice = choice
			play(game.id)
			game.player1choice
		end

		def set_player2_choice(choice, gid)
			game = @games.values.find {|x| x.id == gid.to_i}
			game.player2choice = choice
			play(game.id)
			game.player2choice
		end

	# Main gameplay functions
		def play(gid)
		 	game	= @games.values.find {|game| game.id == gid.to_i}
		 	match	= @matches.values.find {|match| match.id == game.mid.to_i}
		 	player1move = game.player1choice
		 	player2move = game.player2choice
		 	player1 = match.player1
		 	player2 = match.player2

		 	if match.player1wins < 3 && match.player2wins < 3
			 	if player1move && player2move
					if player1move == player2move
		      #Tie (Add functionaliy later)
			    elsif player1move == 'rock' && player2move == 'paper'
			    	game.winner = player2
			      match.player2wins += 1
			    	create_game(match.id)
			    elsif player1move == 'rock' && player2move == 'scissors'
			    	game.winner = player1
			      match.player1wins += 1
			    	create_game(match.id)
			    elsif player1move == 'paper' && player2move == 'rock'
			    	game.winner = player1
			      match.player1wins += 1
			    	create_game(match.id)
			    elsif player1move == 'paper' && player2move == 'scissors'
			    	game.winner = player2
			      match.player2wins += 1
			    	create_game(match.id)
			    elsif player1move == 'scissors' && player2move == 'rock'
			    	game.winner = player2
			      match.player2wins += 1
			    	create_game(match.id)
			    elsif player1move == 'scissors' && player2move == 'paper'
			    	game.winner = player1
			      match.player1wins += 1
			    	create_game(match.id)
			    end
			  end
		  end
		end

		def create_invite(inviter_id, invitee_id)
			invite = Invite.new(inviter_id, invitee_id)
			@invites[invite.id] = invite
			invite
		end


		def update_invite_status(id)
			@invites[id].status = "accepted"
		end


	end
end