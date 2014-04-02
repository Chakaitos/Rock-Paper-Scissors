class Match
  attr_reader :player1, :player2
  attr_accessor :player1wins, :player2wins
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1wins = 0
    @player2wins = 0
  end

  def play_game(choice1, choice2)
    if @player1wins < 3 && @player2wins < 3
      play(choice1, choice2)
    end
  end



end
