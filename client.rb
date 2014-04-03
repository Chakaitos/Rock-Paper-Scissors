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

			sign_command = gets.chomp

			if sign_command.to_i == 1
				RPS::TerminalClient.sign_in
			elsif sign_command.to_i == 2
				RPS::TerminalClient.sign_up
			elsif sign_command.to_i == 3
				puts "Have a nice day!"
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

		  until command == 'quit' || command == 'q'

				category = command.split(' ')[0].downcase
				action = command.split(' ')[1].downcase
				params = command.split(' ')[2..-1].join(' ')

				# if command == 'help'
				#   RPS::TerminalClient.help
				#   command = gets.chomp
				# end

		  	case category
		  	when 'invite'
		  		case action
				  when "create"
				  	user_to_invite = params[0]
					  result = RPS::CreateInvite.run({ :session_id => @session_id, :invitee_id => user_to_invite})
					  if result.success?
					  	puts "Invite sent from #{result.inviter.name} to #{result.invitee.name}."
					  else
					  	if result.error == :invitee_not_found
					  		puts "Invitee not found!"
					  	end
					  end
					  command = gets.chomp
					end
				end


			end #Ends the until loop
		end #Ends the run commands method

		def self.help
			puts "Available Commands:
  			\tusers list - List all users
  			\tmatch list - List active matches
  			\tmatch play MID - Start playing game with id=MID
  			\tinvites - List all pending invites
  			\tinvite accept IID - Accept invite with id=IID
  			\tinvite create USERNAME - Invite user with username=USERNAME to play a game
				\tmatch list"
				RPS::TerminalClient.run_commands
		end






	end
end
RPS::TerminalClient.start
