require './spec/spec_helper.rb'

describe 'Database' do

  before do
    @db = RPS.db
  end

    it "initializes with 4 data repo" do
      expect(@db.users).to eq({})
      expect(@db.matches).to eq({})
      expect(@db.games).to eq({})
      expect(@db.sessions).to eq([])
    end
    
    it "makes a new user" do
      expect(@db.make_user("sally").name).to eq("sally")
    end

    it "updates the user's name" do
     jackie = @db.make_user("jackie")
      @db.update_user(jackie.id,"johnny")
      expect(jackie.name).to eq("johnny")
    end

    it "gets user based on id" do
      jones = @db.make_user("jonesy")
      expect(@db.get_user(jones.id)).to eq(jones)
    end

    it "deletes a user" do
      jones = @db.make_user("jonesy")
      expect(@db.delete_user(jones.id)).to eq({})
    end

    it "shows all users" do
      jones = @db.make_user("jonesy")
      expect(@db.show_all_users).to eq({jones.id=>jones})
    end

    it "creates a new match" do
      User.class_variable_set :@@counter, 0
      john = User.new("john")
      joe = User.new("joe")
      match = @db.create_match(john,joe)
      expect(match.id).to eq(1)
    end

    it "shows all matches" do
      john = User.new("john")
      joe = User.new("joe")
      match = @db.create_match(john,joe)
      expect(@db.show_all_matches).to eq({match.id => match})
    end

    it "gets a match based on id" do
      john = User.new("john")
      joe = User.new("joe")
      match = @db.create_match(john,joe)
      expect(@db.get_match(match.id)).to eq(match)
    end
end