require_relative './lib/rps.rb'
require 'io/console'


module RPS

	class TerminalClient
		def self.start
			@db = RPS.db

			puts " __      __       .__                                     __              ________                                ____   ___/\          ____________________  _________
						/  \    /  \ ____ |  |   ____  ____   _____   ____      _/  |_  ____      \______ \_______   ______  _  __        \   \ /   )/_____     \______   \______   \/   _____/
						\   \/\/   // __ \|  | _/ ___\/  _ \ /     \_/ __ \     \   __\/  _ \      |    |  \_  __ \_/ __ \ \/ \/ /  ______ \   Y   //  ___/      |       _/|     ___/\_____  \
						 \        /\  ___/|  |_\  \__(  <_> )  Y Y  \  ___/      |  | (  <_> )     |    `   \  | \/\  ___/\     /  /_____/  \     / \___ \       |    |   \|    |    /        \
						  \__/\  /  \___  >____/\___  >____/|__|_|  /\___  >     |__|  \____/     /_______  /__|    \___  >\/\_/             \___/ /____  >      |____|_  /|____|   /_______  /
						       \/       \/          \/            \/     \/                               \/            \/                              \/              \/                  \/ "
			puts "[1] Sign in\n[2] Sign up"

			command = gets.chomp

		  until command == 'quit' || command == 'q'

				category = command.split(' ')[0].downcase
				action = command.split(' ')[1].downcase
				params = command.split(' ')[2..-1].join(' ')

				if command == 'help'
				  TM::TerminalClient.help
				  command = gets.chomp
				end

		  	case category
		  	when 'invite'
		  		case action
				  when "create"
				  	user_to_invite = params[0]
					  result = RPS::CreateInvite.run({ :session_id => @session.id, :invitee_id => user_to_invite})
					  if result.success?
					  	puts "Invite sent from #{result.inviter.name} to #{result.inviter.name}."
					  else
					  	if result.error == :invitee_not_found
					  		puts "Invitee not found!"
					  	end
					  end
					  command = gets.chomp
					end
				when 'users'
					case action
					when 'list'
						users_list
				end
			when 'match'
				case action
				when 'list'
					match_list
				end


			end
		end

		def users_list
			users = @db.show_all_users
			puts "User List: [ID]:   [NAME]"
			users.each{|x| puts "			  #{x.id}:   #{x.name}"}
			
		end

		def match_list
			matches = @db.show_all_matches
		end




	end
end

RPS::TerminalClient.start
