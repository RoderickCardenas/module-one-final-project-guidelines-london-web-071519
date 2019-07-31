class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :game

    def self.here_are_all_the_reviews
        Game.all.each do |game|
            self.all.each do |review|
                # binding.pry
                # 0
                if game.id == review.game_id
                    puts "Review ID: #{review.id}, Title: #{game.title}, Content: '#{review.content}', Rating: #{review.rating}/10"
                end
            end
        end
    end
    
    def self.perfect_ratings
        puts "These titles have scored a 10/10 review!"
        self.all.select{|review| review.rating > 9}
    end

    def self.worst_ratings
        puts "These titles have scored a 10/10 review!"
        self.all.select{|review| review.rating > 9}
    end

    def self.worst_to_best
        "Here are all the reviews sorted by rating, from the worst to the best"
        self.all.sort_by{|review| review.rating}
    end

    def self.best_to_worst
        "Here are all the reviews sorted by rating, from the best to the worst"
        self.all.sort_by{|review| review.rating}
    end

    def grab_game_from_review
        Game.all.select{|game| game.id == self.game_id}
    end
end