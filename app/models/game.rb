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


  def self.waiting(user)
    Game.includes(:users).where(:players_count => 1).where("id != ?", user.id)
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

    if (self.board[current_position[0]][current_position[1]] != player_piece)
      return false
    else                                                  # they are moving their own piece
      if self.board[future_position[0]][future_position[1]] = 0           # are they moving to an empty space?
        # if ((future_position[0] - current_position[0] == dir) && (future_position[1] - current_position[1] == dir)) || (future_position[0] - current_position[0] == -1) && (future_position[1] - current_position[1] == -1)
          self.board[current_position[0]][current_position[1]] = 0            # they are? great, write to the board, advance turn
          self.board[future_position[0]][future_position[1]] = player_piece
          self.turn += 1
          self.save
          return true
        # end
      end
    end
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
