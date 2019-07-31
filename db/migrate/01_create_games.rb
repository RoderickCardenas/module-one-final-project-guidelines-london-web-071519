class CreateGames < ActiveRecord::Migration[5.2]
    def change
        create_table :games do |t|
            t.string :title
            t.string :company
            t.string :genre
            t.string :description
        end
    end
end