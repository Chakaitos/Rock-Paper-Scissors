require './spec/spec_helper.rb'

describe Match do

  it "initalizes with two players and zero wins for both" do
    john = User.new("John")
    drew = User.new("Drew")
    match = Match.new(john, drew)
    expect(match.player1.name).to eq (john.name)
    expect(match.player2.name).to eq (drew.name)
  end

end
