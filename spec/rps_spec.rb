require './spec/spec_helper.rb'

describe Game do

  describe "initialize" do
    it "adds two players to the game" do
      john = User.new("John")
      drew = User.new("Drew")
      game = Game.new(john, drew)
      expect(game.player1.name).to eq (john.name)
      expect(game.player2.name).to eq (drew.name)
    end
  end



end
