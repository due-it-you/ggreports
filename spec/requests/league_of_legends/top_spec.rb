require 'rails_helper'

RSpec.describe "LeagueOfLegends::Tops", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/league_of_legends/top/index"
      expect(response).to have_http_status(:success)
    end
  end
end
