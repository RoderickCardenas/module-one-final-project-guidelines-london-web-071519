require 'tty-prompt' 

class CommandLineInterface

    @@exit = "Not out yet!"

    def current_user
            username = PROMPT.ask("Please enter your username", required: true)
        if User.find_by username: username
            @current_user = User.find_by username: username
        end
    end

    def main_menu
        puts "Welcome to Gamer JunkFood"
        puts ""
        options = [
            {"Account Login" => -> do current_user && cli_options end},
            {"Create a new account" => -> do User.create_account && current_user && cli_options end},
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

    def cli_no_account_options
            options = [
                {"View Games" => -> do Game.here_are_all_games && cli_no_account_options end},
                {"View Reviews" => -> do Review.here_are_all_the_reviews && cli_no_account_options end},
                {"View the top rated games" => -> do Game.top_3_reviews && cli_no_account_options end},
                {"View the worst games" => -> do Game.worst_3_reviews && cli_no_account_options end},
                {"View the games that scored a perfect rating!" => -> do Review.perfect_ratings && cli_no_account_options end},
                {"View the games that scored the worst rating!" => -> do Review.worse_ratings && cli_no_account_options end},
                {"Return to home menu" => -> do main_menu end},
                {"Exit" => -> do exit_app end} 
            ]
            PROMPT.select("What would you like to do?", options)
    end

    def view_games_logged_in
        # binding.pry
        # 0
        options = [
            {"View all games" => -> do Game.here_are_all_games && view_games_logged_in end},
            {"View your collection of games that you have reviewed" => -> do @current_user.my_games && view_games_logged_in end},
            {"View the top rated games" => -> do Game.top_3_reviews && view_games_logged_in end},
            {"View the worst games" => -> do Game.worst_3_reviews && view_games_logged_in end},
            {"Return to home menu" => -> do cli_options && view_games_logged_in end}
        ]
        PROMPT.select("Please select from the following:", options) 


    end

    def view_reviews_logged_in
        options = [
            {"View all reviews" => -> do Review.here_are_all_the_reviews end},
            {"View your reviews" => -> do @current_user.my_reviews end},
            {"View the games that scored a perfect rating!" => -> do Review.perfect_ratings end},
            {"View the games that scored the worst rating!" => -> do Review.worse_ratings end},
            {"Return to home menu" => -> do cli_options end}
        ]
        PROMPT.select("Please select from the following:", options) 
    end

    def editing_options
        options = [
            {"Edit your last review" => -> do @current_user.update_last end},
            {"Choose the review you would like to edit, select by id number" => -> do @current_user.reviews && @current_user.review_edit_by_id && editing_options end},
            {"Return to home menu" => -> do cli_options end}
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
end

