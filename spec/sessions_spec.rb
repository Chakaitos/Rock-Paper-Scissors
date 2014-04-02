require './spec/spec_helper.rb'

describe 'Sessions' do

  it "initializes with a unique session id" do
    User.class_variable_set :@@counter, 0
    user = User.new("hi")
    session = Session.new(user.id)
    expect(session.id).to eq(1)
  end
end