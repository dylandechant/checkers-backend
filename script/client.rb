require 'httparty'
require 'pry'

class CheckersUser 
  include HTTParty
  base_uri 'https://warm-spire-6158.herokuapp.com'
  #base_uri 'http://localhost:3000'
  
  def initialize(auth_token, game_id)
    @token = auth_token
    @game_id = game_id
  end

  def game_show
    self.class.get("/games/#{@game_id}", :query => {:auth_token => @token})
  end

  def make_move(move)
    self.class.put("/games/#{@game_id}", :body => {:auth_token => @token,
                                                   :move => move.to_json})
  end
end

def prompt_user(prompt, validator, error_msg)
  puts "\n#{prompt}\n"
  result = gets.chomp
  until result =~ validator
      puts "\n#{error_msg}\n"
      result = gets.chomp
  end
  puts
  result
end

def print_game(game)
  puts "\n The current game board is ... \n"
  game.each do |row|
    puts row.join(' | ')
  puts "-" * 30
  end
  puts
end

def ask_for_move
  start = prompt_user("Which piece would you like to move? x,y (0,0 is top left).", /^[0-7]\,[0-7]$/,
    "You have to supply input for a valid position '0,0' to '7,7'.")
  finish = prompt_user("Where would you like to move this piece? x,y", /^[0-7]\,[0-7]$/,
    "You have to supply input for a valid position! '0,0' to '7,7'.")

  [start.split(','), finish.split(',')].map{ |x| x.map(&:to_i) }
end

def take_turn(player, p1, p2)
  game_json = player.game_show
  # puts game_json.code, game_json.message
  game = JSON.parse(game_json)
  print_game(game['board'])

  puts "You are: #{player == p1 ? 'player 1' : 'player 2'}"
  move = ask_for_move(board)
  response = player.make_move(move)
  # binding.pry
end

def play_game(player1, player2, game_id)
  current_player = player1
  until prompt_user("Do you want to keep playing?", /[yn]/i, "Choose 'y' or 'n' please!") == 'n'
    take_turn(current_player, player1, player2)
    current_player = current_player == player1 ? player2 : player1
  end
end

def get_auth_token(user)
  prompt_user("What is the auth token for #{user}?", /^[0-9a-zA-Z\-_]{20}$/,
    "Please give me a real hash asshole.")
end

token1 = get_auth_token("player 1")
token2 = get_auth_token("player 2")
game_id = prompt_user("What is the ID of the game to play?", /^\d+$/, "C'mon. Gimme a valid ID.")

play_game(CheckersUser.new(token1, game_id), CheckersUser.new(token2, game_id), game_id)
