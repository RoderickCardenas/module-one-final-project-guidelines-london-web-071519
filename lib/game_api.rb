require 'unirest'
require 'json'
require 'pry'
require 'rest-client'
require 'uri'

    def search_games(game_string)
    response = Unirest.get "https://chicken-coop.p.rapidapi.com/games?title=#{game_string}",
    headers:{
    "X-RapidAPI-Host" => "chicken-coop.p.rapidapi.com",
    "X-RapidAPI-Key" => "f9ad7e0712msh15661c980138b29p18127djsnc9b7548347eb"
    }
    title = response.body
    title.map{|k, v|
        if k == "result"
            v.each do |titles|
                titles
            end
        end
    }.compact[0]
    end

    def game_detail(result_object)
        response = Unirest.get "https://chicken-coop.p.rapidapi.com/games/Borderlands%202?platform=ps3",
        headers:{
            "X-RapidAPI-Host" => "chicken-coop.p.rapidapi.com",
            "X-RapidAPI-Key" => "f9ad7e0712msh15661c980138b29p18127djsnc9b7548347eb"
        }
    end


    binding.pry
    0
    search_games("Zelda")