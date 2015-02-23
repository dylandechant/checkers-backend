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
    start = move[0]
    finish = move[1]

    valid = false

    if move.length == 2
      if (start[Y]-finish[Y] > 1) || (start[Y]-finish[Y] < -1) # jump move?
        valid = jump(move)
      else
        valid = single_move(move)
      end     
    end
    valid
  end

  def jump(move)
    player_piece = set_piece
    dir = game_var

    start = move[0]
    finish = move[1]

    if open_move?(finish) && players_piece?(start) && take_piece?(start, finish, player_piece)
      return true
    else
      return false
    end
  end

  def take_piece?(start, finish, player_piece)
    op = set_opponent
    dir = game_var
    if (start[Y]+2 == finish[Y]) || (start[Y]-2 == finish[Y]) # validity of jump
      if start[Y] < finish[Y] #going right
        if (self.board[start[X]+dir][start[Y]+1] != player_piece) || (self.board[start[X]+dir][start[Y]+1] != 0)
          self.board[start[X]+dir][start[Y]+1] = 0
          write_board(start, finish, player_piece)
          return true
        elsif (self.board[start[X]+dir][start[Y]-1] != player_piece) || (self.board[start[X]+dir][start[Y]-1] != 0) #going left
          self.board[start[X]+dir][start[Y]-1] = 0
          write_board(start, finish, player_piece)
          return true
        end
      end
    end
  end


  def single_move(move)

    player_piece = set_piece
    dir = game_var

    start = move[0]
    finish = move[1]

    if open_move?(finish) && players_piece?(start) && x_valid?(start, finish, dir) && y_valid?(start, finish, dir)
      write_board(start, finish, player_piece)
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
    set_user_turn
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

  def set_opponent
    if self.turn.even?
      return 2
    else
      return 1
    end
  end

  private
    def set_board
      self.board = BOARD
    end

    def set_user_turn
      if self.users.length == 2
        if self.user_turn == self.users.first.email
          self.user_turn = self.users.last.email
        else
          self.user_turn = self.users.first.email
        end
      else
        self.user_turn = nil
      end
      self.save
    end

    # def set_user_turn
    #   if self.users.length > 0
    #     if self.turn.even?
    #       self.user_turn = self.users.first.email
    #     else
    #       if self.users.first != self.users.last
    #         self.user_turn = self.users.last.email
    #       else
    #         self.user_turn = nil
    #       end
    #     end
    #   end
    # end
end
