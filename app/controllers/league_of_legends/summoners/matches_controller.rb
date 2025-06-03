require "net/http"
require "uri"
require "json"

class LeagueOfLegends::Summoners::MatchesController < ApplicationController
  def index
    searched_summoner = Summoner.find(params[:summoner_id])
    puuid = searched_summoner.puuid

    # 入力されたサモナーの試合のリストを取得
    platform_routing_value = "na1.api.riotgames.com"
    platform = platform_routing_value.split(".").first
    regional_routing_value = "americas.api.riotgames.com"
    api = "/lol/match/v5/matches/by-puuid/#{puuid}/ids"
    uri = URI.parse("https://#{regional_routing_value}#{api}")
    request = Net::HTTP::Get.new(uri)
    request["X-Riot-Token"] = ENV["RIOT_DEVELOPMENT_API"]
    response_data = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    matches_data = JSON.parse(response_data.body)
    matches_data_limit_5 = matches_data.slice(0,5)

    matches_data_arr = []

    matches_data_limit_5.each do |match_id|
      api = "/lol/match/v5/matches/#{match_id}"
      uri = URI.parse("https://#{regional_routing_value}#{api}")
      request = Net::HTTP::Get.new(uri)
      request["X-Riot-Token"] = ENV["RIOT_DEVELOPMENT_API"]
      response_data = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      @matches_data_arr << JSON.parse(response_data.body)
    end
  end
end
