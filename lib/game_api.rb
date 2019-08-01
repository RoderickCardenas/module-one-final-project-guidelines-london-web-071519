# require 'unirest'
# require 'json'
# require 'pry'
# require 'rest-client'
# require 'uri'
# # require_relative '../config/environment'
# # require_relative './models/games'


#     def search_games(game_string)
#     response = Unirest.get "https://chicken-coop.p.rapidapi.com/games?title=#{game_string}",
#     headers:{
#     "X-RapidAPI-Host" => "chicken-coop.p.rapidapi.com",
#     "X-RapidAPI-Key" => "72b307385bmsh14f08276b00e7dbp131dd7jsn788da4d7fea3"
#     }
#     title = response.body
#     title.map{|k, v|
#         if k == "result"
#             v.each do |titles|
#                 titles
#             end
#         end
#     }.compact[0]
    
#         binding.pry
#         0
# end

# search_games("borderlands")

# #     def game_detail(game_title, game_platform)
# #         response = Unirest.get "https://chicken-coop.p.rapidapi.com/games/#{URI.encode(game_title)}?platform=#{URI.encode(game_platform)}",
# #         headers:{
# #             "X-RapidAPI-Host" => "chicken-coop.p.rapidapi.com",
# #             "X-RapidAPI-Key" => "f9ad7e0712msh15661c980138b29p18127djsnc9b7548347eb"
# #         }
# #         title = response.body
# #         # binding.pry
# #         title.map {|k, v|
# #             if k == "result"
# #                 # "#{v.values[0]}, published by #{v.values[7]} and developed by #{v.values[6]}.
# #                 # Genre: #{v.values[3]}
# #                 # Description:
# #                 # #{v.values[2]}"
# #                 # v.values[0]
# #                 # v.values[7]
# #                 # v.values[3]
# #                 # v.values[2]
# #             end
# #         }.compact[0]
# #     end
    
    
 
# def game_detail(game_title, game_platform)
#     response = Unirest.get "https://chicken-coop.p.rapidapi.com/games/#{URI.encode(game_title)}?platform=#{URI.encode(game_platform)}",
#     headers:{
#         "X-RapidAPI-Host" => "chicken-coop.p.rapidapi.com",
#         "X-RapidAPI-Key" => "72b307385bmsh14f08276b00e7dbp131dd7jsn788da4d7fea3"
#     }
#     title = response.body
#     title.map {|k, v|
#         if k == "result"
#             Game.create(v.values[0], v.values[7], v.values[3],v.values[2])
#             # "#{v.values[0]}, published by #{v.values[7]} and developed by #{v.values[6]}.
#             # Genre: #{v.values[3]}
#             # Description:
#             # #{v.values[2]}"
#             # v.values[0]
#             # v.values[7]
#             # v.values[3]
#             # v.values[2]
#         end
#     }.compact[0]
# end



# search_games("Zelda")
# game_detail("Borderlands 2", "ps3")