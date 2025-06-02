require 'rails_helper'

RSpec.describe "LeagueOfLegends::Top", type: :request do
  describe "GET /index" do
    it 'HTTPステータスコードが302である' do
      get "/"
      expect(response).to have_http_status(:found)
    end
  end
end
