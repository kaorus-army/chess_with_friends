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

  end # context when player not signed in

end
