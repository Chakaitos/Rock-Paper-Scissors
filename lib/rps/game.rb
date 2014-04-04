class Game
  attr_reader :id, :mid
  attr_accessor :player1choice, :player2choice, :winner
  @@counter = 0
  def initialize(mid)
    # @player1 = player1
    # @player2 = player2
    @@counter +=1
    @id = @@counter
    @game_counter = 1
    @match_id = mid
    @player1choice = nil
    @player2choice = nil
    @winner = nil
  end



end
