class User < ActiveRecord::Base
    has_many :reviews
    has_many :games, through: :reviews
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

    def delete_last_review
        self.reviews.last.destroy
    end
end