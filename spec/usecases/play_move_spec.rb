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
    it "returns nil for player 1 if other player has not moved" do
      result = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session1.id })
      expect(result.success?).to eq(true)
      expect(result.game).to eq(nil)
    end

    xit "returns nil for player 2 if other player has not moved" do
      result = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session2.id })
      expect(result.success?).to eq(true)
      expect(result.game).to eq(nil)
    end
  end

  xit "sets winner/tie and returns result if other player has moved and increments score" do
    result1 = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session1.id })
    result2 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
    match = result2.match
    expect(result2.game.winner).to eq(@user2.id)
    expect(match.user2_score).to eq(1)
    expect(match.user1_score).to eq(0)
    result3 = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session1.id })
    result4 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
    expect(result4.game.winner).to eq(@user2.id)
    expect(match.user2_score).to eq(2)
    expect(match.user1_score).to eq(0)
    result5 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session1.id })
    result6 = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session2.id })
    expect(result6.game.winner).to eq(@user1.id)
    expect(match.user2_score).to eq(2)
    expect(match.user1_score).to eq(1)
    result7 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session1.id })
    result8 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
    expect(result8.game.winner).to eq(0)
    expect(match.user2_score).to eq(2)
    expect(match.user1_score).to eq(1)
    result9 = subject.run({ :move => "rock", :match_id => @match.id, :session_id => @session1.id })
    result10 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
    expect(match.user2_score).to eq(3)
    expect(match.winner).to eq(@user2.id)
    result11 = subject.run({ :move => "paper", :match_id => @match.id, :session_id => @session2.id })
    expect(result11.error?).to eq(true)
    expect(result11.error).to eq(:match_complete)
  end
end

