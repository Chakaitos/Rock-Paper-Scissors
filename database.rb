module RPS

	def self.db
		@__db_instance ||= Database.new
	end

	class Database
		# attr_reader :users, :matches, :games, :sessions

		def initialize
			@users = {}
			@matches = {}
			@games = {}
			@sessions = []
		end
	end
end