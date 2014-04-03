require './spec/spec_helper.rb'

describe User do

  describe "initialize" do
    it "allows two players are initialized" do
      john = User.new("John", "abc")
      expect(john.name).to eq("John")
    end

    it "gives an id when player is initialized" do
      User.class_variable_set :@@counter, 0
      john = User.new("John", "abc")
      expect(john.id).to eq(1)
    end

    it "can be initialized with a password" do
      john = User.new("John", "abc")
      expect(john.password).to eq ("abc")
    end
  end
end
