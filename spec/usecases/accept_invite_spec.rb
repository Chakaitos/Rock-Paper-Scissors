require './spec/spec_helper.rb'

describe RPS::AcceptInvite do
  before do
    @db = RPS.db
    @user1 = @db.make_user("Drew","123abc")
    @user2 = @db.make_user("Chris","123abc")
    @session = @db.create_session(@user1.id)
    @invite = @db.create_invite(@user2.id, @user1.id)
  end

  # Errors
  it "will return an error if the invite id does not exist" do
    result = subject.run({ :session_id => @session.id, :invite_id => 509 })
    expect(result.error).to eq(:invite_not_found)
    expect(result.error?).to eq(true)
  end

 it "will return an error if the user is not logged in" do
    result = subject.run({ :session_id => 2354, :invite_id => @invite.id })
    expect(result.error).to eq(:session_not_found)
    expect(result.error?).to eq(true)
  end

  it "will return an error if user was not invited to invite" do
    invite = @db.create_invite(@user1.id, @user2.id)
    result = subject.run({ :session_id => @session.id, :invite_id => invite.id })
    expect(result.error).to eq(:user_not_invited)
    expect(result.error?).to eq(true)
  end

  # Success!
  it "match gets created when an invite was accepted" do
    result = subject.run({ :session_id => @session.id, :invite_id => @invite.id })
    expect(result.success?).to eq(true)
    match = result.match
    expect(match.player1).to eq(@user2.id)
    expect(match.player2).to eq(@user1.id)
  end
end
