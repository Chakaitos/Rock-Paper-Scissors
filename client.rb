require_relative './lib/rps.rb'
require 'io/console'


module RPS

	class TerminalClient
		def self.start
			@db = RPS.db

			puts "   ▄████████    ▄███████▄    ▄████████ "
			puts "  ███    ███   ███    ███   ███    ███ "
			puts "  ███    ███   ███    ███   ███    █▀  "
			puts " ▄███▄▄▄▄██▀   ███    ███   ███        "
			puts "▀▀███▀▀▀▀▀   ▀█████████▀  ▀███████████ "
			puts "▀███████████   ███                 ███ "
			puts "  ███    ███   ███           ▄█    ███ "
			puts "  ███    ███  ▄████▀       ▄████████▀  "

			puts ""

			puts "[1] Sign in\n[2] Sign up \n[3] To Exit"

			sign_command = gets.chomp.to_i

		case sign_command
			when 1
				RPS::TerminalClient.sign_in
			when 2
				RPS::TerminalClient.sign_up
			when 3
				RPS::TerminalClient.good_bye
			else
				puts "Wrong Input!"
				RPS::TerminalClient.start
		end

		end #Ends the start method

		def self.sign_in
			puts "Username:"
			name = gets.chomp
			if name == "q"
				RPS::TerminalClient.start
			else
			puts "Password:"
			password = gets.chomp
			result = RPS::SignIn.run({:name => name, :password => password})
		  if result.success?
		  	@session_id = result.session_id
		  	puts "#{name} has signed in successfully."
		  	RPS::TerminalClient.help
		  else
		  	if result.error == :invalid_name
		  		puts "That username does not exist. Please register..."
		  		RPS::TerminalClient.sign_up
		  	elsif result.error == :invalid_password
		  		puts "The password is incorrect. Please retype your credentials or press q to quit"
		  		RPS::TerminalClient.sign_in
		  	end
		  end
		end
	end

		def self.sign_up
			puts "Username:"
			name = gets.chomp
			puts "Password:"
			password = gets.chomp
			result = RPS::SignUp.run({:name => name, :password => password})
		  if result.success?
		  	puts "#{result.user.name} successfully signed up, please log in to play."
		    RPS::TerminalClient.sign_in
		  else
		  	if result.error == :name_taken
		  		puts "That username already exists."
		  	elsif result.error == :weak_password
		  		puts "The password has to be at least 3 characters"
		  	end
		  end
		end

		def self.run_commands
			command = gets.chomp

				category = command.split(' ')[0].downcase
				action = command.split(' ')[1].downcase
				@params = command.split(' ')[2..-1].join(' ')

				# if command == 'help'
				#   RPS::TerminalClient.help
				#   command = gets.chomp
				# end

		  	case category
			  	when 'invite'
			  		case action
					  when "create"
							RPS::TerminalClient.create_invite
						  command = gets.chomp
						when "accept"
							RPS::TerminalClient.accept_invite
						  command = gets.chomp
						# Lists all the invites
						when 'list'
							RPS::TerminalClient.invite_list
							command = gets.chomp
						end

					# Lists all the users
					when 'users'
						case action
						when 'list'
							RPS::TerminalClient.users_list
							command = gets.chomp
						end


					# Lists all the matches
					when 'match'
						case action
						when 'list'
							RPS::TerminalClient.match_list
							command = gets.chomp
						when "play"
							RPS::TerminalClient.play_game
							command = gets.chomp
						end


					# Signs out the user
					when 'sign'
						case action
						when 'out'
							RPS::TerminalClient.sign_out
						end

					end #Ends the category

		end #Ends the run commands method

		def self.help
			puts "Available Commands:"
			puts "\tusers list - List all users"
			puts "\tmatch list - List active matches"
			puts "\tmatch play MID - Start playing game with id=MID"
			puts "\tinvite list - List all pending invites"
			puts "\tinvite accept IID - Accept invite with id=IID"
			puts "\tinvite create USERNAME - Invite user with username=USERNAME to play a game"

			RPS::TerminalClient.run_commands
		end

		def self.users_list
			users = @db.show_all_users
			puts "User List:"
			puts "\t[ID]   \t[NAME]"
			users.each{|x| puts "\t  #{x.id}\t#{x.name}"}
		end

		def self.match_list
			result = RPS::ListActiveMatches.run({:session_id => @session_id})
			if result.success?
				puts "Match List: [ID]"
				result.matches.each{|x| puts "           #{x.id} "}
			elsif result.error?
				puts "There were no matches"
			end
		end

		def self.invite_list
			result = RPS::ListInvites.run({:session_id => @session_id})
			if result.error?
				puts "There were no invites"
			else
				invites = @db.show_all_invites
				puts "Pending Invites: [ID]"
				invites.each{|x| puts "             #{x.id}"}
			end
		end

		def self.create_invite
		  result = RPS::CreateInvite.run({:session_id => @session_id, :invitee_id => @params})
		  if result.success?
		  	puts "Invite sent from #{result.inviter.name} to #{result.invitee.name}."
		  else
		  	if result.error == :invitee_not_found
		  		puts "Invitee not found!"
		  	elsif result.error == :session_not_found
		  		puts "Session not found!"
		  	end
		  end
		end

		def self.accept_invite
			result = RPS::AcceptInvite.run({:session_id => @session_id, :invite_id => @params})
			if result.success?
				puts "Match has begun with match ID: #{result.match.id}"
			else
				if result.error == :invite_not_found
					puts "Invite not found!"
				elsif result.error == :user_not_invited
					puts "User not invited!"
				end
			end
		end

		def self.play_game
			puts "Choose 'rock','paper', or 'scissors':"
			move = gets.chomp
			result = RPS::PlayMove.run({:session_id => @session_id, :match_id => @params.to_i, :move => move})
			if result.success?
				puts "Decision decided."
			elsif result.error == :move_not_valid
				puts "That move is not valid!"
			end
		end

		def self.sign_out
			@db.delete_session(@session_id)
			RPS::TerminalClient.start
		end

		def self.good_bye
			puts "Bye!"
		end

	end
end
RPS::TerminalClient.start
