require './spec/spec_helper.rb'

# describe RPS::SignIn do
#   before do
#     @db = RPS.db
#     @user = @db.make_user("Jose", 'abc')
#   end
#   it "should not sign in and return an  error if name is invalid" do
#     result = RPS::SignIn.run(:name => "drew", :password => "abc")
#     expect(result.error).to eq(:invalid_name)
#   end
#   it "should not sign in and return an  error if name is invalid" do
#     result = RPS::SignIn.run(:username => "Jose", :password => "xyz")
#     expect(result.error).to eq(:invalid_password)
#   end
#   it "should sign the user in with good credentials" do
#     result = RPS::SignIn.run(:username => "Jose", :password => "abc")
#     test = @db.get_user_from_session(result.session_id)
#     expect(test).to eq(@user.id)
#   end
# end