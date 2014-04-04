require './spec/spec_helper.rb'

describe RPS::CreateInvite do
  before do
    @db = RPS.db
    @user1 = @db.make_user("Drew","1234")
    @user2 = @db.make_user("Jose","1234")
    @session = @db.create_session(@user1.id)
  end

  it "returns error if invitee does not exist" do
    result = subject.run({ :session_id => @session.id, :invitee_id => 6000})
    expect(result.error).to eq(:invitee_not_found)
  end

  it "works" do
    result = subject.run({ :session_id => @session.id, :invitee_id => @user2.id})
    expect(result.success?).to eq(true)
  end
end
