class SetDefaultValueTurn < ActiveRecord::Migration
  def change
    change_column :games, :turn, :integer, default: 0
  end
end
