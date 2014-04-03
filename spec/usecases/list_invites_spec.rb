require './spec/spec_helper.rb'

describe 'ListInvites' do 

before do
  @db = RPS.db
  @user1 = @db.make_user("john",:password => "123")
  @user2 = @db.make_user("joe", :password => "abc")
  @session = @db.create_session(@user1.id)
end

it "throws error if user isn't logged on" do 
    result = RPS::ListInvites.run({:session_id => 1})
    expect(result.error).to eq(:no_session_found)
    expect(result.error?).to eq(true)
  end

it "returns no error if there arent any invites" do 
  result = RPS::ListInvites.run({:session_id => @session.id})
  expect(result.error).to eq(:no_invites_for_user)
  expect(result.error?).to eq (true)
end

it "shows list of all pending invites" do 
  invite = @db.create_invite(@user1.id,@user2.id)
  result = RPS::ListInvites.run({:session_id => @session.id})
  expect(result.invites.last.inviter_id).to eq(@user1.id)
  expect(result.invites.last.invitee_id).to eq(@user2.id)
  expect(result.invites.last.id).to eq(invite.id)
  end

it "doesn't show accepted invites" do 
  invite = @db.create_invite(@user1.id,@user2.id)
  invite2 = @db.create_invite(@user1.id,@user2.id)


  invite2.mid = 1
  result = RPS::ListInvites.run({:session_id => @session.id})
  expect(result.invites.last.id).to eq(invite.id)
end

end