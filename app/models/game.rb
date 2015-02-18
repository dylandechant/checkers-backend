class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  before_create :set_board

  serialize :board

  BOARD = [[1, 0, 1, 0, 1, 0, 1, 0],
           [0, 1, 0, 1, 0, 1, 0, 1],
           [1, 0, 1, 0, 1, 0 ,1, 0],
           [0, 0, 0, 0, 0, 0, 0, 0],
           [0, 0, 0, 0, 0, 0, 0, 0],
           [0, 2, 0, 2, 0, 2, 0, 2],
           [2, 0, 2, 0, 2, 0, 2, 0],
           [0, 2, 0, 2, 0, 2, 0, 2]]

  private
    def set_board
      self.board = BOARD
    end
end
