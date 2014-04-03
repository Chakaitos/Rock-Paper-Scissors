

# Create our module. This is so other files can start using it immediately
module RPS
end

# Require all of our project files
require_relative 'rps/user.rb'
require_relative 'rps/game.rb'
require_relative 'rps/match.rb'
require_relative 'rps/sessions.rb'
require_relative 'rps/invite.rb'
require_relative 'rps/database.rb'
require_relative 'rps/usecase/usecase.rb'
require_relative 'rps/usecase/list_active_matches.rb'
require_relative 'rps/usecase/list_invites.rb'
require_relative 'rps/usecase/list_users.rb'
require_relative 'rps/usecase/accept_invite.rb'
require_relative 'rps/usecase/create_invite.rb'
require_relative 'rps/usecase/signin.rb'
require_relative 'rps/usecase/play_move.rb'
require_relative 'rps/usecase/signup.rb'
require 'pry-debugger'
