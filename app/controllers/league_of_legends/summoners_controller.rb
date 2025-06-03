require 'net/http'
require 'uri'
require 'json'

class LeagueOfLegends::SummonersController < ApplicationController
  def create
    name, tagline = summoners_params[:name].gsub(" ","").split('#', 2)
  
    # 入力されたサモナーのpuuidの取得
    platform_routing_value = "na1.api.riotgames.com"
    platform = platform_routing_value.split('.').first
    regional_routing_value = "americas.api.riotgames.com"
    api = "/riot/account/v1/accounts/by-riot-id/#{name}/#{tagline}?api_key=#{ENV['RIOT_DEVELOPMENT_API']}"
    uri = URI.parse("https://#{regional_routing_value}#{api}")
    response_data = Net::HTTP.get(uri)
    summoner_data = JSON.parse(response_data)
    
    Summoner.create({
      name: summoner_data["gameName"],
      tagline: summoner_data["tagLine"],
      platform: platform,
      puuid: summoner_data["puuid"]
    })
  end

  private

  def summoners_params
    params.require(:summoner).permit(:name)
  end
end
