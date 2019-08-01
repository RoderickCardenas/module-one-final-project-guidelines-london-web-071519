require 'tty-prompt' 

class CommandLineInterface

    @@exit = "Not out yet!"

    def current_user
            username = PROMPT.ask("Please enter your username", required: true)
        if User.find_by username: username
            @current_user = User.find_by username: username
        end
        cli_options
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
        cli_options
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
            {"View the top rated games" => -> do top_three && main_menu end},
            {"View the worst games" => -> do bottom_three && main_menu end},
            {"View the games that scored a perfect rating!" => -> do perfect_games end},
            {"View the games that scored the worst rating!" => -> do trash_games end},
            {"Exit" => -> do exit_app end}   
        ]
        PROMPT.select("Please choose your login type, feel free to browse reviews/games", options, per_page: 4) 
    end

    def cli_options
        options = [
            {"View Games" => -> do view_games_logged_in && cli_options end},
            {"View Reviews" => -> do view_reviews_logged_in && cli_options end},
            {"Edit your reviews" => -> do editing_options end},
            {"Delete your own reviews" => -> do delete_reviews end},
            {"Change your username" => -> do change_username end},
            {"Logout and exit" => -> do exit_app end}   
        ]
        PROMPT.select("What would you like to do?", options, filter: true)
    end

    def delete_reviews
        options = [

            {"View Reviews" => -> do view_reviews_logged_in && cli_options end},
            {"Return to account menu" => -> do cli_options end},
            {"Logout and exit" => -> do exit_app end} 
        ]
        PROMPT.select("What would you review would you like to delete?", options)
    end

    def view_games_logged_in
        # binding.pry
        # 0
        options = [
            {"View all games" => -> do here_are_all_games end},
            {"Select a game to review" => -> do select_to_review && view_games_logged_in end},
            {"View your collection of games that you have reviewed" => -> do my_games && view_games_logged_in end},
            {"View the top rated games" => -> do top_three && view_games_logged_in end},
            {"View the worst games" => -> do bottom_three && view_games_logged_in end},
            {"Return to home menu" => -> do cli_options && view_games_logged_in end},
            {"Logout and exit" => -> do exit_app end} 
        ]
        PROMPT.select("Please select from the following:", options) 


    end

    def view_reviews_logged_in
        options = [
            {"View all reviews" => -> do here_are_all_the_reviews end},
            {"View your reviews" => -> do my_reviews end},
            {"Select a game to review" => -> do select_to_review && view_games_logged_in end},
            {"View the games that scored a perfect rating!" => -> do perfect_games end},
            {"View the games that scored the worst rating!" => -> do trash_games end},
            {"Return to home menu" => -> do cli_options end},
            {"Logout and exit" => -> do exit_app end} 
        ]
        PROMPT.select("Please select from the following:", options) 
    end

    def editing_options
        options = [
            {"Edit your last review" => -> do update_last end},
            {"Choose the review you would like to edit" => -> do select_to_edit end},
            {"Delete last review entry" => -> do @current_user.delete_last_review && my_reviews end},
            {"Return to home menu" => -> do cli_options end},
            {"Logout and exit" => -> do exit_app end}    
        ]
        PROMPT.select("Please select from the following:", options) 
    end

###########################
############

def my_games
    @current_user.games.each do |game|
        puts "Title: #{game.title} | Genre: #{game.genre}"
    end
end

def my_reviews
    @current_user.reviews.each do |review|
        puts "Title: #{review.game.title} |Genre: #{review.game.genre} | Review: #{review.content} | Rating #{review.rating}"
    end
    cli_options
end

def update_last
    to_update = @current_user.reviews.last
    to_update.content = PROMPT.ask("What would you like your new content to say?")
    to_update.rating = PROMPT.ask("What would you like your new rating for this game to be?")
    to_update.save
    puts ", ""Title: #{to_update.game.title} | #{to_update.game.genre} | #{to_update.content} | #{to_update.rating}", ""
    cli_options
end

############
############################

    # Here are the methods regarding reviews
    def here_are_all_the_reviews
        Review.all.each{|review| puts "Title: #{review.game.title}, Content: '#{review.content}', Rating: #{review.rating}/10"}
    end

    def here_are_all_the_reviews_not_logged
        Review.all.each{|review| puts "Title: #{review.game.title}, Content: '#{review.content}', Rating: #{review.rating}/10"}
        main_menu
    end

    def perfect_games
        Review.perfect_ratings.each{|rev| puts "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!"}
        cli_options
    end

    def trash_games
        Review.worst_ratings.each {|rev| puts "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!"}
    end

    def top_three
        Review.top_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
    end

    def bottom_three
        Review.bottom_3.each{|review| puts "", "Title: #{review.game.title} | Content: '#{review.content}' | Rating: #{review.rating}/10!", ""}
    end

    def here_are_all_games
        Review.every_unique_game.each{|review| puts "", "Game ID: #{review.game.id}, Title: #{review.game.title}, Genre: #{review.game.genre}", ""}.uniq
        cli_options
    end

    def here_are_all_games_not_logged
        Review.every_unique_game.each{|review| puts "", "Game ID: #{review.game.id}, Title: #{review.game.title}, Genre: #{review.game.genre}", ""}.uniq
        main_menu
    end

    def select_to_review
        options = []
        here_are_all_games.each do |review|
        options << {"Title: #{review.game.title}, Genre: #{review.game.genre}" => -> do selected_to_review(review) end}
        end
        PROMPT.select("Select the game you would like to review", options, filter: true)
    end

    def selected_to_review(review)
        puts "#{review.game.title} | #{review.game.genre}"
        content = PROMPT.ask("Start writing your review for this game.")
        rating = PROMPT.ask("What would you rate this game out of 10?")
        Review.create(game_id: review.game.id, user_id: @current_user.id, content: content, rating: rating)
        new_review = @current_user.reviews.last
        puts "", "Thanks for letting the community know what's what!", "", "Title: #{new_review.game.title} | #{new_review.game.genre} | #{new_review.content} | #{new_review.rating}/10"
        cli_options
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
        new_review = review
        new_review.save
        puts "", "Great, here are your newly edited review", "", "Title: #{new_review.game.title} | #{new_review.game.genre} | #{new_review.content} | #{new_review.rating}/10"
        cli_options
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

