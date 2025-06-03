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
    api = "/riot/account/v1/accounts/by-riot-id/#{name}/#{tagline}"
    uri = URI.parse("https://#{regional_routing_value}#{api}")
    request = Net::HTTP::Get.new(uri)
    request["X-Riot-Token"] = ENV['RIOT_DEVELOPMENT_API']
    response_data = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    summoner_data = JSON.parse(response_data.body)
    binding.pry

    summoner = Summoner.new({
                    name: summoner_data["gameName"],
                    tagline: summoner_data["tagLine"],
                    platform: platform,
                    puuid: summoner_data["puuid"]
                  })

    if summoner.save
      redirect_to league_of_legends_summoner_matches_path(summoner_id: summoner.id)
    end
  end

  private

  def summoners_params
    params.require(:summoner).permit(:name)
  end
end
