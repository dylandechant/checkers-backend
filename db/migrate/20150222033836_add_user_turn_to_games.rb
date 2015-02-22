class AddUserTurnToGames < ActiveRecord::Migration
  def change
    add_column :games, :user_turn, :string
  end
end
