require 'unirest'
require 'json'
require 'pry'
require 'rest-client'
require 'uri'
require_relative '../config/environment'
require_relative '../lib/models/games'
require_relative '../lib/models/reviews'
require_relative '../lib/models/users'
require_relative '../lib/game_api'


binding.pry
0
puts "Welcome to Gamer JunkFood"
puts "Would you like to create an account?"

account = gets.chomp

if account == "yes".downcase
    puts "Please enter your name"
    name = gets.chomp
    puts "Now enter your desired username"
    username = gets.chomp
    User.create(name: name, username: username)
elsif account == "no".downcase
    puts "Hope to see you again soon! You need an account to view games and leave reviews."
else
    puts "Please say 'yes' or 'no'"
end

puts "Type in the name of the game (see what we did there? No? Ok...) ehem"
puts "Please enter the title you would like to view:"

game_name = gets.chomp

search_games(game_name)

puts "Here are your results, please select the appropriate number from 0 to select the correct title."

number = gets.chomp

game_select = search_games(game_name)[number].values[0]
game_platform = search_games(game_name)[number].values[1]

game_detail(game_select, game_platform)
    #code to end program

