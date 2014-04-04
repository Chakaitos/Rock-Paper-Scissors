module RPS

	def self.db
		@__db_instance ||= DB.new(@app_db_name)
	end

	def self.db_name=(db_name)
		@app_db_name = db_name
	end

	class DB
		# attr_reader :users, :matches, :games, :sessions
		attr_accessor :users, :matches, :games, :sessions, :invites, :matches_users
		def initialize
			@users = {}
			@matches = {}
			@games = {}
			@invites = {}
			@sessions = {}
		end

		# Create methods - CRUD
		def make_user(name, password)
			user = User.new(name, password)
			@users[user.id.to_i] = user
			user
		end

		def create_match(user1_id,user2_id)
			match = Match.new(user1_id,user2_id)
			@matches[match.id.to_i] = match
			match
		end

		def create_game(mid)
			game = Game.new(mid)
			@games[game.id] = game
			game
		end

		def create_invite(inviter_id, invitee_id)
			invite = Invite.new(inviter_id, invitee_id)
			@invites[invite.id] = invite
			invite
		end

		def create_session(uid)
			session = Session.new(uid)
			@sessions[session.id] = session
			session
		end

		# Read methods - CRUD
		def get_user(uid)
			@users[uid]
		end

		def show_all_users
			@users.values
		end

		def get_user_by_name(name)
			@users.values.find {|user| user.name == name}
		end

		def get_user_by_session(sid)
			@sessions[sid].user_id
		end

		def get_match(mid)
			@matches[mid.to_i]
		end

		def show_all_matches
			@matches.values
		end

		def get_game(gid)
			@games[gid.to_i]
		end

		def show_all_games
			@games.values
		end

		def get_invite(iid)
			@invites[iid.to_i]
		end

		def show_all_invites
			@invites.values
		end

		def get_session(sid)
			@sessions[sid.to_i]
		end

		def show_all_sessions
			@sessions.values
		end

		# Update methods - CRUD
		def update_user(uid, options={})
		 	user = @users[uid.to_i]
			if options[:name]
				user.name = options[:name]
			end
			if
				user.password = options[:password]
			end
			user
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

		def update_invite_status(iid)
			@invites[iid].status = "accepted"
		end

		# Update methods - CRUD
		def delete_user(uid)
			@users.delete(uid)
			@users
		end

		def delete_match(mid)
			@matches.delete(mid)
			@matches
		end

		def delete_game(gid)
			@games.delete(gid)
			@games
		end

		def delete_invite(iid)
			@invites.delete(iid)
			@invites
		end

		def delete_session(sid)
			@sessions.delete(sid)
			@sessions
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
			      match.winner = player2 if match.player2wins == 3
			    	create_game(match.id)
			    elsif player1move == 'rock' && player2move == 'scissors'
			    	game.winner = player1
			      match.player1wins += 1
			      match.winner = player1 if match.player1wins == 3
			    	create_game(match.id)
			    elsif player1move == 'paper' && player2move == 'rock'
			    	game.winner = player1
			      match.player1wins += 1
			      match.winner = player1 if match.player1wins == 3
			    	create_game(match.id)
			    elsif player1move == 'paper' && player2move == 'scissors'
			    	game.winner = player2
			      match.player2wins += 1
			      match.winner = player2 if match.player2wins == 3
			    	create_game(match.id)
			    elsif player1move == 'scissors' && player2move == 'rock'
			    	game.winner = player2
			      match.player2wins += 1
			      match.winner = player2 if match.player2wins == 3
			    	create_game(match.id)
			    elsif player1move == 'scissors' && player2move == 'paper'
			    	game.winner = player1
			      match.player1wins += 1
			      match.winner = player1 if match.player1wins == 3
			    	create_game(match.id)
			    end
			  end
		  end
		end
	end
end
