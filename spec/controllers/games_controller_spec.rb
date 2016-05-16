require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  context "when player signed in" do

    before(:example) do
      @player1 = create(:player)
      sign_in(@player1)
    end

    describe "#show" do

      it "should successfully load the show page" do
        game = create(:game)
        sign_out @player1
        sign_in game.players.first
        get :show, id: game.id

        expect(response).to have_http_status(:success)
      end

      it "should 404 error if the game doesn't exist" do
        get :show, id: 'TACO'

        expect(response).to have_http_status(:not_found)
      end

      it "should restrict access to only players associated with the game" do
        game = create(:game)
        # Signed in as @player1
        get :show, id: game.id

        expect(response).to have_http_status(:forbidden)
      end

    end # describe #show

    describe "#index" do

      it "should sucessfully show the game listing page" do
        get :index

        expect(response).to have_http_status(:success)
      end

    end # describe #index

    describe "#new" do

      it "should successfully show the new game form" do
        get :new

        expect(response).to have_http_status(:success)
      end

    end # describe #new

    describe "#create" do

      it "should allow players to create a new game" do
        post :create, game: {
          nickname: "A game nickname"
        }
        game = Game.last

        expect(response).to redirect_to(game_url(game))
        expect(game.nickname).to eq "A game nickname"
        expect(Game.count).to eq 1
        expect(game.players.first).to eq @player1
      end

    end # describe #create

    describe "#join" do

      before(:example) { @game = create(:game) }

      it "allows players to join a game" do
        get :join, id: @game.id

        expect(response).to redirect_to(game_url(@game))
        expect(@game.players.count).to eq 2
      end

      it "assigns players correct colors" do
        get :join, id: @game.id

        expect(@game.playerships.where(player_id: @game.players.first.id).first.color).to eq 'white'
        expect(@game.playerships.where(player_id: @player1.id).first.color).to eq 'black'
      end

      it "restricts access to only two players" do
        player2 = create(:player)
        @game.playerships.create(player: player2)
        # now @game is at "full capacity"
        get :join, id: @game.id

        expect(response).to redirect_to(games_url)
        expect(@game.players.include?(@player1)).to eq false
      end

      it "404 errors if the game is not found" do
        get :join, id: 'CAT'

        expect(response).to have_http_status(:not_found)
      end

      it "redirects to the game if the player has already joined" do
        # Player is already associated with the game
        @game.playerships.create(player: @player1)
        get :join, id: @game.id

        expect(response).to redirect_to(game_url(@game))
        expect(@game.players.count).to eq 2
      end

    end # describe #join

  end # context when player signed in

  context "when player not signed in" do

    describe "#show" do

      it "should redirect to the sign-in page" do
        game = create(:game)
        get(:show, id: game.id)

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #show

    describe "#index" do

      it "should redirect to the sign-in page" do
        get(:index)

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #index

    describe "#new" do

      it "should redirect to the sign-in page" do
        get(:new)

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #new

    describe "#create" do

      it "should redirect to the sign-in page" do
        post(:create, game: {nickname: "A nickname"})

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #create

    describe "#join" do

      it "redirects to the sign-in page" do
        get(:join, id: 'anything')

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #join

  end # context when player not signed in

end
