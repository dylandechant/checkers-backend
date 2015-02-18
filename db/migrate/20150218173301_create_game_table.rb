class CreateGameTable < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.text :board
      t.integer :turn
      t.integer :winner
      t.integer :loser
      t.boolean :finished, default: false
    end
  end
end
