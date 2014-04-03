class User
  attr_accessor :name, :password
  attr_reader :id
  @@counter = 0
  def initialize(name, password)
    @@counter += 1
    @id = @@counter
    @name = name
    @password = password
    @match_wins = []
    @match_loses = []
  end
end
