class Player < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :game

  validates_uniqueness_of :user_id, :scope => :game_id
end
