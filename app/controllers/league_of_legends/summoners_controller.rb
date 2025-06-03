class LeagueOfLegends::SummonersController < ApplicationController
  def create
    name, tagline = summoners_params[:name].gsub(" ","").split('#')
  end

  private

  def summoners_params
    params.require(:summoner).permit(:name)
  end
end
