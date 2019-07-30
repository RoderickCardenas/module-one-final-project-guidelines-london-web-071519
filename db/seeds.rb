require 'faker'

random_content = ["Good fun", "Terrible game, who made this???", "Seriously, stop making games", "Loved it, so much attention to detail", "You need to buy this!", "Pretty average", "not bad"]
random_rating = [0,1,2,3,4,5,6,7,8,9,10]

# 10.times do
#     Game.create(title: Faker::Game.title, genre: Faker::Game.genre)
# end

# 10.times do
#     User.create(name: Faker::Name.name, username: Faker::Superhero.name)
# end

# Game.all.each do |g|
#     User.all.each do |u|
#         Review.create(game_id: g.id, user_id: u.id, content: random_content.sample, rating: random_rating.sample )
#     end
# end
binding.pry
0