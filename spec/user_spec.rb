require './spec/spec_helper.rb'

describe User do

  describe ".initialize" do
    it "allows two players are initialized" do
      john = User.new("John")
      expect(john.name).to eq("John")
    end

    it "gives an id when player is initialized" do
      User.class_variable_set :@@counter, 0
      john = User.new("John")
      expect(john.id).to eq(1)
    end

    it "user can create a password" do
      john = User.new("John")
      john.set_password("hello")
      expect(john.password).to eq ("hello")
    end

    it "can be initialized with a password" do
      john = User.new("John", password: 'abc')
      expect(john.password).to eq ("abc")
    end
  end
end
