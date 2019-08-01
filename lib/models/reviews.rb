class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :game
    
    def self.perfect_ratings
        self.all.select{|review| review.rating > 9}
    end

    def self.every_unique_game
        Review.all.uniq{|review| review.game_id}
    end

    def self.every_unique_user
        Review.all.uniq{|review| review.user_id}
    end

    def self.worst_ratings
        self.all.select{|review| review.rating < 2}
    end

    def self.worst_to_best
        self.all.sort_by{|review| review.rating}
    end

    def self.best_to_worst
        self.all.sort_by{|review| review.rating}
    end

    def grab_game_from_review
        Game.all.select{|game| game.id == self.game_id}
    end

    def self.top_3
        Review.all.max_by(3){|review|review.rating}
    end

    def self.bottom_3
        Review.all.sort_by.min_by(3){|review|review.rating}
    end
end