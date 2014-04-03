require './spec/spec_helper.rb'

describe 'ListActiveMatches' do
  before do 
    @db = RPS.db
    @user = @db.make_user("joe",:password => "123")
    @session = @db.create_session(@user.id)
  end
  
  it "throws error if user not logged on" do
    list = RPS::ListActiveMatches.new
    result = list.run({:session_id => 1})
    expect(result.error).to eq(:no_session_found)
    expect(result.error?).to eq(true)
  end

  it "throws error if no active matches are found" do
    list = RPS::ListActiveMatches.new
    result = list.run({:session_id => @session.id})
    expect(result.error).to eq(:no_active_matches_for_user)
    expect(result.error?).to eq(true)
  end

  it "shows all active matches" do 
    user2 = @db.make_user("jane",:password => "abc")
    match = @db.create_match(@user,user2)
    match2 = @db.create_match(@user,user2)
    list = RPS::ListActiveMatches.new
    result = list.run({:session_id => @session.id})
    expect(result.success?).to eq(true)
    expect(result.matches).to be_a(Array)
    expect(result.matches.last.id).to eq(match2.id)

  end

end