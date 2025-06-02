class LeagueOfLegends::TopController < ApplicationController
  http_basic_authenticate_with name: "dev", password: "private-dev"
  def index
  end
end
