class RemoveColumnFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :player1_id
    remove_column :games, :player2_id
  end
end
