class RemovePlayerCountFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :players_count, :integer
  end
end
