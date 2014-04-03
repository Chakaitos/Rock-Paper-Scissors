require_relative 'lib/rps.rb'
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
		  	when 'project'
		  		case action
					when "list"
					  TM::TerminalClient.project_list
					  command = gets.chomp
				  when "create"
					  TM::TerminalClient.project_create(params)
					  command = gets.chomp
					when "show"
					  TM::TerminalClient.project_show(params)
					  command = gets.chomp
					when "history"
					  TM::TerminalClient.project_history(params)
					  command = gets.chomp
					when "recruit"
						TM::TerminalClient.project_recruit(params)
					  command = gets.chomp
					when "employees"
						TM::TerminalClient.project_employees(params)
					  command = gets.chomp
					end

				end
			end
		end

		def self.help 
			puts "Available Commands:
		  \thelp - Show these commands again
		  \tproject list - List all projects
		  \tproject create <NAME> - Create a new project with name=NAME
		  \tproject show <PID> - Show remaining tasks for project with id=PID
		  \tproject history <PID> - Show completed tasks for project with id=PID
		  \tproject employees <PID> - Show employees participating in this project
		  \tproject recruit <PID> <EID> - Adds employee EID to participate in project PID
		  \ttask create <PID> <PRIORITY> <DESC> - Add a new task to project with id=PID
		  \ttask assign <TID> <EID> - Assign task TID to employee EID
		  \ttask mark <TID> - Mark task with id=TID as complete
		  \temp list - List all employees
		  \temp create <NAME> - Create a new employee
		  \temp show <EID> - Show employee EID and all participating projects
		  \temp details <EID> - Show all remaining tasks assigned to employee EID, along with the project name next to each task
		  \temp history <EID> - Show completed tasks for employee with id=EID
		  \tquit or q - Quits the program.\n"
		end
	end
end
