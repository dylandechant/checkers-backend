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


  def self.waiting
    Game.where(:players_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end

  def valid_move?(move)
    binding.pry
    valid = false
    if move.length == 2
      valid = single_move(move)
    end

    binding.pry
    valid
  end
#[[x,x],[x,x]]
  def single_move(move)
    player_piece = set_piece
    dir = game_var
    binding.pry
    if (self.board[move[0][0]][move[0][1]] != player_piece)
      binding.pry
      return false
    else                                                  # they are moving their own piece
      if self.board[move[1][0]][move[1][1]] = 0           # are they moving to an empty space?
        self.board[move[0][0]][move[0][1]] = 0            # they are? great, write to the board, advance turn
        self.board[move[1][0]][move[1][1]] = player_piece
        self.turn += 1
        self.save
        binding.pry
        return true
      end
    end
  end

  def game_var
    if self.turn.odd?
      return 1
    else
      return -1
    end
  end

  def set_piece
    if self.turn.odd?
      return 1
    else
      return 2
    end
  end

  private
    def set_board
      self.board = BOARD
    end
end
