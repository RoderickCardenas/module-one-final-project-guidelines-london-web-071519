require 'unirest'
require 'json'
require 'pry'
require 'uri'
require 'tty-prompt'
require_relative '../config/environment'
require_relative '../lib/models/games'
require_relative '../lib/models/reviews'
require_relative '../lib/models/users'
require_relative '../lib/models/cli_methods'
require_relative '../lib/game_api'

cli = CommandLineInterface.new

cli.run