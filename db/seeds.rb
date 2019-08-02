require 'faker'

random_good_content = [
    "Good fun, you got to try it", 
    "Loved it, so much attention to detail", 
    "You need to buy this!", "Pretty average",
    "not bad",
    "One of the best games I have ever played!",
    "If there is one space left for a game in your life, this is it."
]
random_bad_content = [
    "Terrible game, who made this???", 
    "Seriously, stop making games",
    "Worse than average", 
    "Such a broken game",
    "Is it too harsh to wish bad things on the creators who wasted my life?",
    "WOW, you did it! You made the worst game, ever..."
]
random_rating = [1,2,3,4,5,6,7,8,9,10]

10.times do
    Game.create(title: Faker::Game.title, genre: Faker::Game.genre)
end

10.times do
    User.create(name: Faker::Name.name, username: Faker::Superhero.name)
end

Game.all.each do |g|
    User.all.each do |u|
        Review.create(game_id: g.id, user_id: u.id, content: nil, rating: random_rating.sample )
    end
end
# binding.pry
# 0
Review.all.each do |r|
    if r.rating >= 5
        # binding.pry
        r.content = random_good_content.sample
        r.save
    else
        r.content = random_bad_content.sample
        r.save
    end
end