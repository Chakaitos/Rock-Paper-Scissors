class Game
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

 def play(choice1, choice2)
    if choice1 == choice2
      "This hand was a tie."
    elsif choice1 == 'rock' && choice2 == 'paper'
      Match.player2_wins += 1
    elsif choice1 == 'rock' && choice2 == 'scissors'
      @player1_wins += 1
    elsif choice1 == 'paper' && choice2 == 'rock'
      @player1_wins += 1
    elsif choice1 == 'paper' && choice2 == 'scissors'
      @player2_wins += 1
    elsif choice1 == 'scissors' && choice2 == 'rock'
      @player2_wins += 1
    elsif choice1 == 'scissors' && choice2 == 'paper'
      @player1_wins += 1
    else
      "Invalid choice. Enter 'rock', 'paper' or 'scissors'"
    end
  end

end
