class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wins, :integer
    add_column :users, :losses, :integer
    add_column :users, :forfits, :integer
  end
end
