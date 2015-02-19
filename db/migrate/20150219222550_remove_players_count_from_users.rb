class RemovePlayersCountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :players_count
  end
end
