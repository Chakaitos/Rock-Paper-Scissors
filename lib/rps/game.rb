class Game
  attr_reader :player1, :player2, :match
  attr_accessor :choice1, :choice2

  def initialize(choice1, choice2, mid)
    @choice1 = choice1
    @choice2 = choice2
    @mid = mid 
    # @player1 = player1
    # @player2 = player2
    # @match = match

  end

# Main gameplay functions
 # def play(choice1, choice2)
 #    if choice1 == choice2
 #      #Tie (Add functionaliy later)
 #    elsif choice1 == 'rock' && choice2 == 'paper'
 #      @match.player2wins += 1
 #    elsif choice1 == 'rock' && choice2 == 'scissors'
 #      @match.player1wins += 1
 #    elsif choice1 == 'paper' && choice2 == 'rock'
 #      @match.player1_wins += 1
 #    elsif choice1 == 'paper' && choice2 == 'scissors'
 #      @match.player2_wins += 1
 #    elsif choice1 == 'scissors' && choice2 == 'rock'
 #      @match.player2_wins += 1
 #    elsif choice1 == 'scissors' && choice2 == 'paper'
 #      @match.player1_wins += 1
 #    else
 #      "You're dumb"
 #    end
 #  end

end