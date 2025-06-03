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
    uri = URI.parse("https://#{regional_routing_value}#{api}?count=5")
    request = Net::HTTP::Get.new(uri)
    request["X-Riot-Token"] = ENV["RIOT_DEVELOPMENT_API"]
    response_data = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    matches_ids = JSON.parse(response_data.body)

    @matches = []

    # 各試合の詳細データを取得
    matches_ids.each do |match_id|
      api = "/lol/match/v5/matches/#{match_id}"
      uri = URI.parse("https://#{regional_routing_value}#{api}")
      request = Net::HTTP::Get.new(uri)
      request["X-Riot-Token"] = ENV["RIOT_DEVELOPMENT_API"]
      response_data = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      match = JSON.parse(response_data.body)
      participant = match["info"]["participants"].find { |p| p["puuid"] == puuid }
      team_id = participant["teamId"]
      team_info = match["info"]["teams"].find { |team| team["teamId"] == team_id }

      @matches << {
        match: match,
        did_win: team_info["win"]
      }
    end
  end
end
