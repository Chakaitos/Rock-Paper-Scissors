require './spec/spec_helper.rb'

describe Game do

  before do
    @john = User.new("John")
    @drew = User.new("Drew")
    @match = Match.new(@john, @drew)
    @game = Game.new(@match.id)
  end

  describe "initialize" do
    it "initializes with a match" do
      expect(@game.mid).to eq (@match.id)
    end
  end



end
