require './spec/spec_helper.rb'

describe "list_users" do
  before do

    @db = RPS.db
    @user = @db.make_user("jon",:password => "123")
    @session = @db.create_session(@user.id)
  end
  it "throws an error if no user is logged on" do 

    result = RPS::ListUsers.new
    
end  
end