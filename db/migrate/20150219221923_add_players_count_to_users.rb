class AddPlayersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :players_count, :integer
  end
end
