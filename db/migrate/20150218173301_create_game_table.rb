class CreateGameTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :board
      t.integer :turn
      t.integer :winner
      t.integer :loser
      t.boolean :finished, default: false
    end
  end
end
