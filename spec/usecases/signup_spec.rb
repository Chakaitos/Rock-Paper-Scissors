require './spec/spec_helper.rb'

describe RPS::SignUp do
  before do
    @db = RPS::DB.new
  end

  # it "adds a user" do
  #   user = @db.make_user("jose", :password => "123abc")

  #   result = subject.run(:name => user.name, :password => user.password)
  #   expect(result.success?).to eq true
  # end

end
