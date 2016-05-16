require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  context "when player signed in" do

    describe "#show" do

      before(:example) do
        @player1 = create(:player)
        sign_in(@player1)
      end

      it "should successfully load the show page" do
        game = create(:game)
        get :show, id: game.id

        expect(response).to have_http_status(:success)
      end

    end # describe #show

  end # context when player signed in

  context "when player not signed in" do

    describe "#show" do

      it "should redirect to the sign-in page" do
        game = create(:game)
        get(:show, id: game.id)

        expect(response).to redirect_to(new_player_session_url)
      end

    end # describe #show

  end # context when player not signed in

end
