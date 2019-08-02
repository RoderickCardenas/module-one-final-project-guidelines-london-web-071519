require 'tty-prompt' 

class CommandLineInterface

    @@exit = "Not out yet!"

    def current_user
            username = PROMPT.ask("Please enter your username", required: true)
            puts ""
        if User.find_by username: username
            @current_user = User.find_by username: username
            view_main_menu_logged_in
        else
            puts "", "Incorred username or does not exist! Please create an account or try again ^_^", ""
            main_menu
        end
    end

    def create_account
        name = PROMPT.ask("Please enter your name")
        puts ""
        username = PROMPT.ask("Now enter your desired username")
            while User.find_by username: username
                puts "", "This user already exists, please choose another username", ""
                name = PROMPT.ask("Please enter your name")
                puts ""
                username = PROMPT.ask("Now enter your desired username")
            end
                User.create(name: name, username: username)
                @current_user = User.all.last
        @current_user
        view_main_menu_logged_in
    end

#The run method is here
#
#
#
    def run
        main_menu
    end
#
#
#
#The run method is here

    def main_menu
        puts "Welcome to Gamer JunkFood"
        puts ""
        options = [
            {"Account Login" => -> do current_user end},
            {"Create a new account" => -> do create_account end},
            {"View Games" => -> do here_are_all_games_not_logged end},
            {"View Reviews" => -> do here_are_all_the_reviews_not_logged end},
            {"View the top rated games" => -> do top_three_not_logged end},
            {"View the worst games" => -> do bottom_three_not_logged end},
            {"View the games that scored a perfect rating!" => -> do perfect_games_not_logged end},
            {"View the games that scored the worst rating!" => -> do trash_games_not_logged end},
            {"Exit" => -> do exit_app end}   
        ]
        PROMPT.select("Please choose your login type, feel free to browse reviews/games", options, per_page: 4) 
    end

    def view_main_menu_logged_in
        # binding.pry
        # 0
        options = [
            {"View all games" => -> do here_are_all_games end},
            {"View all reviews" => -> do here_are_all_the_reviews end},
            {"Select a game to review" => -> do select_to_review end},
            {"View your collection of games that you have reviewed" => -> do my_games end},
            {"View the top rated games" => -> do top_three end},
            {"View the worst games" => -> do bottom_three end},
            {"View the games that scored a perfect rating!" => -> do perfect_games end},
            {"View the games that scored the worst rating!" => -> do trash_games end},
            {"View your reviews" => -> do my_reviews end},
            {"Select a game to review" => -> do select_to_review end},
            {"Edit your last review" => -> do update_last end},
            {"Choose the review you would like to edit" => -> do select_to_edit end},
            {"Select a review that you would like to delete (cannot be reversed!)" => -> do select_to_delete end},
            {"Change your username" => -> do change_username end},
            {"Logout and exit" => -> do exit_app end} 
        ]
        PROMPT.select("Please select from the following:", options, per_page: 4) 
    end

###########################
############

def reload_user
    @current_user.reload
end

def my_games
    @current_user.reviews.each do |review|
        puts "", "Title: #{review.game.title} | Genre: #{review.game.genre} | Your review: #{review.content} | Your rating: #{review.rating}/10", ""
    end
    view_main_menu_logged_in
end

def my_reviews
    @current_user.reviews.each do |review|
        puts "", "Title: #{review.game.title} |Genre: #{review.game.genre} | Review: #{review.content} | Rating #{review.rating}", ""
    end
    view_main_menu_logged_in
end

def change_username
    username = PROMPT.ask("Please enter the new username you would like to have")
    while User.find_by username: username
        puts "", "This user already exists, please choose another username", ""
        username = PROMPT.ask("Please enter the new username you would like to have")
        puts ""
    end
    @current_user.username = username
    @current_user.save
    view_main_menu_logged_in
end

def update_last
    to_update = @current_user.reviews.last
    to_update.content = PROMPT.ask("What would you like your new content to say?")
    puts ""
    to_update.rating = PROMPT.ask("What would you like your new rating for this game to be?")
    puts ""
    to_update.save
    puts ", ""Title: #{to_update.game.title} | #{to_update.game.genre} | #{to_update.content} | #{to_update.rating}", ""
    view_main_menu_logged_in
end

############
############################

    # Here are the methods regarding reviews
    def here_are_all_the_reviews
        Review.all.each{|review| puts "", "Title: #{review.game.title}, Content: '#{review.content}', Rating: #{review.rating}/10", ""}
        view_main_menu_logged_in
    end

    def here_are_all_the_reviews_not_logged
        Review.all.each{|review| puts "", "Title: #{review.game.title}, Content: '#{review.content}', Rating: #{review.rating}/10", ""}
        main_menu
    end

    def perfect_games
        Review.perfect_ratings.each{|rev| puts "", "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!", ""}
        view_main_menu_logged_in
    end

    def trash_games
        Review.worst_ratings.each {|rev| puts "", "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!", ""}
        view_main_menu_logged_in
    end

    def top_three
        Review.top_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
        view_main_menu_logged_in
    end

    def bottom_three
        Review.bottom_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
        view_main_menu_logged_in
    end

    #

    def perfect_games_not_logged
        Review.perfect_ratings.each{|rev| puts "", "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!", ""}
        main_menu
    end

    def trash_games_not_logged
        Review.worst_ratings.each {|rev| puts "", "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!", ""}
        main_menu
    end

    def top_three_not_logged
        Review.top_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
        main_menu
    end

    def bottom_three_not_logged
        Review.bottom_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
        main_menu
    end

    def here_are_all_games
        Review.every_unique_game.each{|review| puts "", "Game ID: #{review.game.id}, Title: #{review.game.title}, Genre: #{review.game.genre}", ""}.uniq
        view_main_menu_logged_in
    end

    def search_games
        Review.every_unique_game.each{|review| puts "", "Game ID: #{review.game.id}, Title: #{review.game.title}, Genre: #{review.game.genre}", ""}.uniq
    end

    def here_are_all_games_not_logged
        Review.every_unique_game.each{|review| puts "", "Game ID: #{review.game.id}, Title: #{review.game.title}, Genre: #{review.game.genre}", ""}.uniq
        main_menu
    end

    def select_to_review
        options = []
        search_games.each do |review|
        options << {"Title: #{review.game.title}, Genre: #{review.game.genre}" => -> do validate_to_review(review) end}
        end
        PROMPT.select("Select the game you would like to review", options, filter: true)
    end

    def validate_to_review(review)
        @current_user.games.each do |game|
            if game.id == review.game_id
                puts "", "You have already reviewed this game! You can edit your review from the main menu", ""
                view_main_menu_logged_in
            end
        end
        selected_to_review(review)
    end

    def selected_to_review(review)
        puts "#{review.game.title} | #{review.game.genre}"
            content = PROMPT.ask("Start writing your review for this game.")
            rating = PROMPT.ask("What would you rate this game out of 10?")
            while rating.to_i > 10 || rating.length > 3 || rating.to_i < 1
                rating = PROMPT.ask("The rating has to be out of 10, What would you rate this game out of 10?")
            end
            Review.create(game_id: review.game.id, user_id: @current_user.id, content: content, rating: rating)
            reload_user
            new_review = @current_user.reviews.last
            puts "", "Thanks for letting the community know what's what!", "" 
            puts "Title: #{new_review.game.title} | #{new_review.game.genre} | #{new_review.content} | #{new_review.rating}/10"
            view_main_menu_logged_in
    end

    def select_to_edit
        options = []
        @current_user.reviews.each do |review|
        options << {"Title: #{review.game.title} | Genre: #{review.game.genre} | Content: #{review.content} | #{review.rating}" => -> do selected_to_edit(review) end}
        end
        PROMPT.select("Select the game you would like to review", options, filter: true)
    end

    def selected_to_edit(review)
        puts "Title: #{review.game.title} | Genre: #{review.game.genre} | Content: #{review.content} | #{review.rating}"
        review.content = PROMPT.ask("Start writing your review for this game.")
        review.rating = PROMPT.ask("What would you rate this game out of 10?")
        while review.rating.to_i > 10 || review.rating.length > 3 || review.rating.to_i < 1
            review.rating = PROMPT.ask("The rating has to be out of 10, What would you rate this game out of 10?")
        end
        new_review = review
        new_review.save
        puts "", "Great, here are your newly edited review", "", "Title: #{new_review.game.title} | #{new_review.game.genre} | #{new_review.content} | #{new_review.rating}/10"
        view_main_menu_logged_in
    end

    def select_to_delete
        options = []
        @current_user.reviews.each do |review|
        options << {"Title: #{review.game.title} | Genre: #{review.game.genre} | Content: #{review.content} | #{review.rating}" => -> do selected_to_delete(review) end}
        end
        PROMPT.select("Select the game you would like to review", options, filter: true)
    end

    def selected_to_delete(review)
        puts "Title: #{review.game.title} | Genre: #{review.game.genre} | Content: #{review.content} | #{review.rating}"
        new_review = review
        new_review.destroy
        puts "Your review has been deleted! Hope you meant to do that o_0"
        @current_user.reviews.reload
        view_main_menu_logged_in
    end
#
#########
# Here ends the methods calling Review class

    def exit_app
        puts ""
        puts "We hope you to see you again soon!"
        puts ""
        exit!
    end
end

