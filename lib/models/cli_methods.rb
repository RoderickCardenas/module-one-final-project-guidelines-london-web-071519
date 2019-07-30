require 'tty-prompt' 

class CommandLineInterface
    
    def run
    puts "Welcome to Gamer JunkFood"

    account_ask = PROMPT.yes?("Would you like to create an account?", required: true)

    account_ask
    
    if account_ask == true   
        name = PROMPT.ask("Please enter your name")
        username = PROMPT.ask("Now enter your desired username, any spaces will be replaced with underscores")
        User.create(name: name, username: username.tr(" ", "_"))
        "Bear in mind your user name has underscores where ever you had spaces."
    end

    if account_ask == false
        puts "You will not be able to leave a review without creating an account"
        one_more = PROMPT.yes?("Do you want to create an account?", required: true)
        one_more
            if one_more == true
                "Please enter your name"
                name = gets.chomp
                "Now enter your desired username"
                username = gets.chomp
                User.create(name: name, username: username.tr(" ", "_"))
            else
                puts "No problem! We hope you join us soon!"
            end
    end

    exit_program = ""

        until exit_program == "exit" do
            game_title = PROMPT.ask("Please enter the title you would like to view:")

            # binding.pry
            # 0
            Game.game_select(game_title)
            exit_program = PROMPT.ask("To exit, type 'exit'; otherwise, type anything else to look through more titles.")
        end
    end  #code to end program
end

