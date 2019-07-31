class Game < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews
    def reviews_rating_best_to_worst
        self.reviews.sort_by{|rev| rev.rating}.reverse
    end

    def self.here_are_all_games
        self.all.each do |game|
        puts "Game ID: #{game.id}, Title: #{game.title}, Genre: #{game.genre}"
        end
    end
    
    def reviews_rating_worst_to_best
        self.reviews.sort_by{|rev| rev.rating}
    end

    def top_3_reviews
        reviews_rating_best_to_worst.max_by(3) {|rev| rev.rating}
    end

    def worst_3_reviews
        reviews_rating_worst_to_best.min_by(3) {|rev| rev.rating}
    end

    def num_reviews
        self.reviews.count
    end

    def rating_array
        reviews.map{|review| review.rating}
    end

    def average_rating
        self.rating_array.sum / self.num_reviews
    end

    def self.all_games
        self.all.map{|game| game.title}
    end

    def self.game_select(game_title)
        self.all.each do |game|
            # binding.pry
            # 0
            if game.title.upcase.upcase.include?(game_title.upcase)
                puts_var = self.all.select{|game| game.title.upcase.include?(game_title.upcase)}[0].title
                puts_var2 = self.all.select{|game| game.title.upcase.include?(game_title.upcase)}[0].genre
                puts puts_var 
                puts puts_var2
                return "#{puts_var} is a #{puts_var2} game"
            end
        end
        puts "Sorry, we don't seem to have that game in our database"
    end
end