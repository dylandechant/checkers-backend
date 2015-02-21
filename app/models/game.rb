class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  before_create :set_board

  validates_length_of :users, maximum: 2, message: "can only have two players"

  serialize :board


  BOARD = [[1, 0, 1, 0, 1, 0, 1, 0],
           [0, 1, 0, 1, 0, 1, 0, 1],
           [1, 0, 1, 0, 1, 0 ,1, 0],
           [0, 0, 0, 0, 0, 0, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 0],
           [0, 2, 0, 2, 0, 2, 0, 2],
           [2, 0, 2, 0, 2, 0, 2, 0],
           [0, 2, 0, 2, 0, 2, 0, 2]]
  X = 0
  Y = 1


  def self.waiting(user)
    Game.joins(:users).where(players_count: 1).where("users.id != #{user.id}")
  end

  def self.active
    Game.where(:finished => false)
  end

  def valid_move?(move)
    valid = false
    if move.length == 2
      valid = single_move(move)
    end
    valid
  end
#[[x,x],[x,x]]
  def single_move(move)

    player_piece = set_piece
    dir = game_var

    current_position = move[0]
    future_position = move[1]

    if open_move?(future_position) && players_piece?(current_position) && x_valid?(current_position, future_position, dir) && y_valid?(current_position, future_position, dir)
      write_board(current_position, future_position, player_piece)
    else
      return false
    end
  end

  def open_move?(spot)
    if self.board[spot[X]][spot[Y]] == 0
      return true
    else
      return false
    end
  end

  def players_piece?(spot)
    player_piece = set_piece
    if self.board[spot[X]][spot[Y]] == player_piece
      return true
    else
      return false
    end
  end

  def x_valid?(start, finish, dir)  # set dir
    if finish[X] == start[X] + dir
      return true
    else
      return false
    end
  end

  def y_valid?(start, finish, dir)
    if (finish[Y] == start[Y] + 1) || (finish[Y] == start[Y] - 1)
      return true
    else
      return false
    end
  end

  def write_board(start, finish, player_piece)
    self.board[start[X]][start[Y]] = 0
    self.board[finish[X]][finish[Y]] = player_piece
    self.turn += 1
    self.save
  end

  def game_var
    if self.turn.even?
      return 1
    else
      return -1
    end
  end

  def set_piece
    if self.turn.even?
      return 1
    else
      return 2
    end
  end

  # private
    def set_board
      self.board = BOARD
    end
end
