require './spec/spec_helper.rb'

describe Game do

  before do
    @john = User.new("John")
    @drew = User.new("Drew")
    @match = Match.new(@john, @drew)
    @game = Game.new(@john, @drew, @match)
  end

  describe "initialize" do
    it "initializes with a match" do
      expect(@game.match).to eq (@match)
    end

    it "adds two players to the game" do
      expect(@game.player1.name).to eq (@john.name)
      expect(@game.player2.name).to eq (@drew.name)
    end
  end

  describe "game play" do
    it "takes player choices and adds 1 point to winner" do
      @game.play('rock', 'scissors')
      expect(@match.player1wins).to eq (1)
    end
  end


end
