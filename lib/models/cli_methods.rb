require 'tty-prompt' 

class CommandLineInterface

    @@exit = "Not out yet!"

    def current_user
            username = PROMPT.ask("Please enter your username", required: true)
        if User.find_by username: username
            @current_user = User.find_by username: username
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
    end
# Here are the methods regarding reviews
    def here_are_all_the_reviews
        Review.all.each{|review| puts "Title: #{review.game.title}, Content: '#{review.content}', Rating: #{review.rating}/10"}
    end

    def perfect_games
        Review.perfect_ratings.each{|rev| puts "Title: #{rev.game.title} | Content: '#{rev.content}' | Rating: #{rev.rating}/10!"}
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
    end
# Here ends the methods calling Review class

    def my_games
        @current_user.games.each do |game|
            puts "Title: #{game.title} | Genre: #{game.genre}"
        end
    end

    def main_menu
        puts "Welcome to Gamer JunkFood"
        puts ""
        options = [
            {"Account Login" => -> do current_user && cli_options end},
            {"Create a new account" => -> do create_account && cli_options end},
            {"View games or reviews without creating an account" => -> do cli_no_account_options end},
            {"Exit" => -> do exit_app end}   
        ]
        PROMPT.select("Please choose your login type or exit the app:", options) 
    end

    def cli_options
        options = [
            {"View Games" => -> do view_games_logged_in && cli_options end},
            {"View Reviews" => -> do view_reviews_logged_in && cli_options end},
            {"Edit your reviews" => -> do editing_options end},
            {"Delete your own reviews" => -> do delete_reviews end},
            {"Change your username" => -> do @current_user.change_username end},
            {"Logout and exit" => -> do exit_app end}   
        ]
        PROMPT.select("What would you like to do?", options, filter: true)
    end

    def cli_no_account_options
        options = [
            {"View Games" => -> do here_are_all_games && cli_no_account_options end},
            {"View Reviews" => -> do here_are_all_the_reviews && cli_no_account_options end},
            {"View the top rated games" => -> do top_three && cli_no_account_options end},
            {"View the worst games" => -> do bottom_three && cli_no_account_options end},
            {"View the games that scored a perfect rating!" => -> do perfect_games && cli_no_account_options end},
            {"View the games that scored the worst rating!" => -> do trash_games && cli_no_account_options end},
            {"Return to home menu" => -> do main_menu end},
            {"Exit" => -> do exit_app end} 
        ]
        PROMPT.select("What would you like to do?", options)
    end

    def delete_reviews
        options = [
            {"Delete last review entry" => -> do @current_user.delete_last_review && delete_reviews end},
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
            {"View all games" => -> do here_are_all_games && view_games_logged_in end},
            {"Select a game to review" => -> do select_to_review && view_games_logged_in end},
            {"View your collection of games that you have reviewed" => -> do @current_user.my_games && view_games_logged_in end},
            {"View the top rated games" => -> do top_3_reviews && view_games_logged_in end},
            {"View the worst games" => -> do worst_3_reviews && view_games_logged_in end},
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
            {"Edit your last review" => -> do @current_user.update_last end},
            {"Choose the review you would like to edit, select by id number" => -> do my_reviews && review_edit_by_id && editing_options end},
            {"Return to home menu" => -> do cli_options end},
            {"Logout and exit" => -> do exit_app end}    
        ]
        PROMPT.select("Please select from the following:", options) 
    end

    def run
        main_menu
    end

    def exit_app
        puts ""
        puts "We hope you to see you again soon!"
        puts ""
        @@exit = "exit"
    end

    def select_to_review
        options = []
        here_are_all_games.each do |review|
        options << {"Title: #{review.game.title}, Genre: #{review.game.genre}" => -> do selected_to_review(game_choice) end}
        end
        game_choice = PROMPT.select("Select the game you would like to review", options, filter: true)
    end
end

