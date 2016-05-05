require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "games#show" do
    it "should successfully load the show page" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
