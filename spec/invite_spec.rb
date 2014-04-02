require './spec/spec_helper.rb'

describe 'Invite' do

  it "initializes an Invite with an invitee and and an inviter" do
    user1 = User.new("homer")
    user2 = User.new("marge")
    invitation = Invite.new(user1.id, user2.id)
    expect(invitation.inviter_id).to eq(user1.id)
    expect(invitation.invitee_id).to eq(user2.id)
  end
end