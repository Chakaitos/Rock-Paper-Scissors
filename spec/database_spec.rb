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
      expect(@db.show_all_users).to eq([jones])
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
      expect(@db.show_all_matches).to eq([match])
    end

    it "gets a match based on id" do
      john = User.new("john")
      joe = User.new("joe")
      match = @db.create_match(john,joe)
      expect(@db.get_match(match.id)).to eq(match)
    end

    describe "game" do
      it "creates a game" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)
        expect(@db.games.count).to eq (1)
      end

      it "set player ones choice" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        choice = @db.set_player1_choice("rock",game.id)
        expect(choice).to eq(game.player1choice)
      end

      it "set player twos choice" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        choice = @db.set_player2_choice("paper",game.id)
        expect(choice).to eq (game.player2choice)
      end

      it "successfully plays the game" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(match.player2wins).to eq(1)
        expect(match.player1wins).to eq(0)
      end

      it "sets the winner for the game" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(game.winner.id).to eq(joe.id)
      end

      it "creates a new game after a game is complete" do 
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(@db.games.count).to eq(2)
      end

      it "only runs if anyone has less than 3 wins" do
        john = User.new("john")
        joe = User.new("joe")
        match = @db.create_match(john,joe)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        @db.set_player1_choice("paper",game.id)
        @db.set_player2_choice("rock",game.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        # This game is ignored
        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(@db.games.count).to eq(5)
        expect(match.player2wins).to eq(3)
      end
    end

    describe "invite" do
      it "creates an invite" do
        john = User.new("john")
        joe = User.new("joe")
        @db.create_invite(john, joe)

        expect(@db.invites.count).to eq(1)
      end

      it "updates an invite" do
        john = User.new("john")
        joe = User.new("joe")
        invite = @db.create_invite(john, joe)
        @db.update_invite_status(invite.id)
        expect(@db.invites.count).to eq(1)
        expect(invite.status).to eq("accepted")
      end
    end

  end
end
