class LeagueOfLegends::SummonersController < ApplicationController
  def create
  end

  private

  def summoners_params
    params.require(:summoner).permit(:name)
  end
end
