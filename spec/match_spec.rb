require './spec/spec_helper.rb'

describe Match do

  before do
    @john = User.new("John")
    @drew = User.new("Drew")
    @match = Match.new(@john, @drew)
  end

  describe "initalize" do
    it "initalizes with two players and zero wins for both" do
      expect(@match.player1.name).to eq (@john.name)
      expect(@match.player2.name).to eq (@drew.name)
    end
  end

end
