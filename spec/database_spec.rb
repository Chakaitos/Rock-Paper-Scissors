require 'spec_helper.rb'

describe 'Database' do

  before do
    @db = RPS.db
  end

  describe "initialize" do
    it "initializes with for data repo" do
      expect(@db.users).to eq({})
      expect(@db.matches).to eq({})
      expect(@db.games).to eq({})
      expect(@db.sessions).to eq({})
      expect(@db.invites).to eq({})
    end
  end

  context "with a couple of users" do
    before do
      @db = RPS.db
      @user1 = @db.make_user("john", "abc")
      @user2 = @db.make_user("joe", "abc")
    end

    it "makes a new user" do
      expect(@db.make_user("sally", "abc").name).to eq("sally")
    end

# TEST NEED TO BE UPDATED FOR PASSWORD
    # it "updates the user's name" do  
    #  jackie = @db.make_user("jackie")
    #   @db.update_user(jackie.id,"johnny")
    #   expect(jackie.name).to eq("johnny")
    # end

    it "gets user based on id" do
      expect(@db.get_user(@user1.id)).to eq(@user1)
    end

    it "deletes a user" do
      # binding.pry
      result = @db.delete_user(@user1.id)
      test = @db.delete_user(@user2.id)
      expect(test).to eq({})
    end

    it "shows all users" do
      expect(@db.show_all_users).to eq([@user1, @user2])
    end

    it "creates a new match" do
      User.class_variable_set :@@counter, 0
      match = @db.create_match(@user1, @user2)
      expect(match.id).to eq(1)
    end

    it "get user by name" do
      test = @db.get_user_by_name(@user1.name)

      expect(test).to eq(@user1)
    end

    it "shows all matches" do
      match = @db.create_match(@user1, @user2)
      expect(@db.show_all_matches).to eq([match])
    end

    it "gets a match based on id" do
      match = @db.create_match(@user1, @user2)
      expect(@db.get_match(match.id)).to eq(match)
    end

    it "deletes a match using the match id" do
      match = @db.create_match(@user1, @user2)
      expect(@db.matches.count).to eq(1)
      @db.delete_match(match.id)
      expect(@db.matches.count).to eq(0)
    end



    describe "game" do
      it "creates a game" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)
        expect(@db.games.count).to eq (1)
      end

      it "set player ones choice" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        choice = @db.set_player1_choice("rock",game.id)
        expect(choice).to eq(game.player1choice)
      end

      it "set player twos choice" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        choice = @db.set_player2_choice("paper",game.id)
        expect(choice).to eq (game.player2choice)
      end

      it "successfully plays the game" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(match.player2wins).to eq(1)
        expect(match.player1wins).to eq(0)
      end

      it "sets the winner for the game" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(game.winner.id).to eq(@user2.id)
      end

      it "creates a new game after a game is complete" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        @db.set_player1_choice("rock",game.id)
        @db.set_player2_choice("paper",game.id)

        expect(@db.games.count).to eq(2)
      end

      it "only runs if anyone has less than 3 wins" do
        match = @db.create_match(@user1, @user2)
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

      it "deletes a game" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)
        expect(@db.games.count).to eq(1)
        @db.delete_game(game.id)
        expect(@db.games.count).to eq(0)
      end
    end

    describe "invite" do
      it "creates an invite" do
        @db.create_invite(@user1, @user2)

        expect(@db.invites.count).to eq(1)
      end

      it "updates an invite" do
        invite = @db.create_invite(@user1, @user2)
        @db.update_invite_status(invite.id)
        expect(@db.invites.count).to eq(1)
        expect(invite.status).to eq("accepted")
      end

      it "creates an invite" do
        invite = @db.create_invite(@user1, @user2)
        expect(@db.invites.count).to eq(1)
        @db.delete_invite(invite.id)

        expect(@db.invites.count).to eq(0)
      end

      it "gets an invite by id" do
        invite = @db.create_invite(@user1, @user2)
        expect(@db.invites.count).to eq(1)
      end
    end

    describe "session" do
      it "creates a session" do
        session = @db.create_session(@user1.id)

        expect(@db.sessions.count).to eq(1)
      end

      it "get user by session" do
        session = @db.create_session(@user1.id)
        test = @db.get_user_by_session(session.id)

        expect(test).to eq(@user1.id)
      end

      it "gets a session by id" do
        session = @db.create_session(@user1.id)
        test = @db.get_session(session.id)

        expect(test.id).to eq(session.id)
      end

      it "deletes a session" do
        session = @db.create_session(@user1.id)
        test = @db.delete_session(session.id)

        expect(@db.sessions).to eq({})
      end
    end

    describe "list" do
      it "lists all the games" do
        match = @db.create_match(@user1, @user2)
        game = @db.create_game(match.id)

        expect(@db.show_all_games).to eq([game])
      end

      it "lists all the invites" do
        invite = @db.create_invite(@user1.id, @user2.id)

        expect(@db.show_all_invites).to eq([invite])
      end

      it "lists all the sessions" do
        session1 = @db.create_session(@user2.id)
        session2 = @db.create_session(@user1.id)

        expect(@db.show_all_sessions).to eq([session1,session2])
      end

      it "lists all the matches" do
        becky = User.new("becky", "abc")
        match = @db.create_match(@user1, @user2)
        match1 = @db.create_match(@user1,becky)

        expect(@db.show_all_matches).to eq([match,match1])
      end
    end
  end
end
