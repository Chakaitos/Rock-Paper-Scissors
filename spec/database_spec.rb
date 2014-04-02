require './spec/spec_helper.rb'

describe 'Database' do

  before do
    @db = RPS.db
  end

  describe "initialize" do
    it "initializes with for data repo" do
      expect(@db.users).to eq({})
      expect(@db.matches).to eq({})
      expect(@db.games).to eq({})
      expect(@db.sessions).to eq([])
    end
  end
end
