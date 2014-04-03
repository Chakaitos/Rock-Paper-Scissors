require './spec/spec_helper.rb'

describe RPS::SignIn do
  before do
    @db = RPS.db
    @user = @db.make_user("Jose", "abc")
  end

  # Error
  it "should not sign in and return an error if name is invalid" do
    # binding.pry
    result = subject.run(:name => "drew", :password => @user.password)
    expect(result.success?).to eq false
    expect(result.error).to eq(:invalid_name)
  end
  it "should not sign in and return an error if password is invalid" do
    result = subject.run(:name => @user.name, :password => "xyz")
    expect(result.success?).to eq false
    expect(result.error).to eq(:invalid_password)
  end

  # Success
  it "should sign the user in with good credentials" do
    result = subject.run(:name => @user.name, :password => @user.password)
    test = @db.get_user_by_session(result.session_id)
    expect(result.success?).to eq true
    expect(test).to eq(@user.id)
  end
end