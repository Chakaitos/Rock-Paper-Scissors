require './spec/spec_helper.rb'

describe RPS::SignUp do
  before do
    @db = RPS.db
    @user = @db.make_user("jose", :password => "123abc")
  end

  # Error
  it "should not let user sign up if the name is taken" do
    # binding.pry
    result = subject.run(:name => "jose", :password => "abc")
    expect(result.success?).to eq false
    expect(result.error).to eq(:name_taken)
  end
  it "should not let user sign up if the password is less than 3 characters" do
    result = subject.run(:name => "drew", :password => "xy")
    expect(result.success?).to eq false
    expect(result.error).to eq(:weak_password)
  end

  # Success
  it "adds a user if the user inputs the correct information" do
    result = subject.run(:name => "chris", :password => "123")
    expect(result.success?).to eq true
  end
end