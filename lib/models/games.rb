class Game < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews
    def reviews_rating_best_to_worst
        self.reviews.sort_by{|rev| rev.rating}.reverse
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
                puts puts_var 
                return puts_var
            end
        end
        puts "Sorry, we don't seem to have that game in our database"
    end
end