

# Create our module. This is so other files can start using it immediately
module RPS
end

# Require all of our project files
require_relative './rps/database.rb'
require_relative './rps/user.rb'
require_relative './rps/game.rb'
require_relative './rps/match.rb'
require_relative './rps/database.rb'
require 'pry-debugger'