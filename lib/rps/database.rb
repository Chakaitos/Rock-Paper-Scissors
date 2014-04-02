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
	end

end
