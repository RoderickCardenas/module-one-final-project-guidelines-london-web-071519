class CreateReviews < ActiveRecord::Migration[5.2]
    def change
        create_table :reviews do |t|
            t.belongs_to :game, index: true
            t.belongs_to :user, index: true
            t.string :content
            t.integer :rating
        end
    end
end