require './spec/spec_helper.rb'

describe RPS::PlayMove do
  before do
    @db = RPS.db
    @user1 = @db.make_user("Drew","abc123")
    @user2 = @db.make_user("Jose","abc123")
    @session1 = @db.create_session(@user1.id)
    @session2 = @db.create_session(@user2.id)
    @match = @db.create_match(@user1.id, @user2.id)
  end

  it "will give an error if session doesn't exist" do
    result = subject.run({ :move => "paper", :match_id => @match.id, :session_id => 1234})
    expect(result.error).to eq(:session_not_found)
    expect(result.error?).to eq(true)
  end

  it "will give an error if move is not valid" do
    result = subject.run({ :move => "hey", :match_id => @match.id, :session_id => @session1.id })
    expect(result.error).to eq(:move_not_valid)
    expect(result.error?).to eq(true)
  end

  describe "Move" do
    it "successfully makes a move for player 1 by session" do
      result = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session1.id })
      expect(result.success?).to eq(true)
    end

    it "returns nil for player 2 if other player has not moved" do
      result = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
      expect(result.success?).to eq(true)
    end
  end
end

