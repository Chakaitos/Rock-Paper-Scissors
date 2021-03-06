require './spec/spec_helper.rb'

describe "list_users" do
  before do

    @db = RPS.db
    @user = @db.make_user("jon",:password => "123")
    @session = @db.create_session(@user.id)
  end
  it "throws an error if no user is logged on" do 

    list = RPS::ListUsers.new
    result = list.run({:session_id => 1})
    expect(result.error).to eq(:no_session_found)
    expect(result.error?).to eq(true)

end  

it "shows a list of all users" do 
  list = RPS::ListUsers.new
  result = list.run({:session_id => @session.id})
  expect(result.users.last.id).to eq(@user.id)
end
end