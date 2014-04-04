class Match
attr_reader :player1, :player2, :id
attr_accessor :player1wins, :player2wins, :winner
@@counter = 0;
  def initialize(player1_id, player2_id)
    @player1_id = player1_id
    @player2_id = player2_id
    @@counter += 1
    @id = @@counter
    @player1wins = 0
    @player2wins = 0
    # @games = []
    @winner = nil
  end

  def play_game(choice1, choice2)
    if @player1wins < 3 && @player2wins < 3
      play(choice1, choice2)
    end
  end

end

