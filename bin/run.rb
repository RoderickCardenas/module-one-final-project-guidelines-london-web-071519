require 'unirest'
require 'json'
require 'pry'
require 'uri'
require 'tty-prompt'
require_relative '../config/environment'
require_relative '../lib/models/games'
require_relative '../lib/models/reviews'
require_relative '../lib/models/users'
require_relative '../lib/game_api'

prompt = TTY::Prompt.new

puts "Welcome to Gamer JunkFood"
account_ask = prompt.yes?("Would you like to create an account?", required: true)

account_ask

if account_ask == true
    puts "Please enter your name"
    name = gets.chomp
    puts "Now enter your desired username"
    username = gets.chomp
    User.create(name: name, username: username)
end

if account_ask == false
    puts "You will not be able to leave a review wihtout creating an account"
    one_more = prompt.yes?("One more time, would you like to create an account?", required: true)
    one_more
    if one_more == true
        puts "Please enter your name"
        name = gets.chomp
        puts "Now enter your desired username"
        username = gets.chomp
        User.create(name: name, username: username)
    else
        puts "No problem! We hope you join us soon!"
    end
end


binding.pry 
puts "Type in the name of the game (see what we did there? No? Ok...) ehem"
puts "Please enter the title you would like to view:"

game_title = gets.chomp
binding.pry
0

# game_name = gets.chomp

# search_games(game_name)

# number = gets.chomp

# game_select = search_games(game_name)[number].values[0]
# game_platform = search_games(game_name)[number].values[1]

# game_detail(game_select, game_platform)
    #code to end program

