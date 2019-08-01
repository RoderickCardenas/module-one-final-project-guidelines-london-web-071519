class User < ActiveRecord::Base
    has_many :reviews
    has_many :games, through: :reviews
    def reviews_rating_best_to_worst
        self.reviews.sort_by{|rev| rev.rating}.reverse
    end

    def my_reviews
        Game.all.each do |game|
            self.reviews.each do |review|
                if review.game_id == game.id
                    puts "Title: #{game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10"
                end
            end
        end
    end

    def delete_last_review
        self.reviews.last.destroy_all
        Reviews.update
        Self.reviews.update
    end

    def update_last
        to_update = self.reviews.last
        to_update.content = PROMPT.ask("What would you like your new content to say?")
        to_update.rating = PROMPT.ask("What would you like your new rating for this game to be?")
        # binding.pry
        to_update.save
        puts "#{self.reviews.last.game_id} | #{self.reviews.last.user_id} | #{self.reviews.last.content} | #{self.reviews.last.rating}"
    end

    # def change_username

    # end

    def all_reviews
        Reviews.all
    end
    
    def reviews_rating_worst_to_best
        self.reviews.sort_by{|rev| rev.rating}
    end

    def review_edit_by_id
        binding.pry
        Review.all.find_by user_id: num = PROMPT.ask("Which Review by ID number would you like to change?")
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

    def delete_last_review
        self.reviews.last.destroy
    end

    def delete_by_game_id(game_id)
        self.reviews.find_by(game_id).destroy
    end
end