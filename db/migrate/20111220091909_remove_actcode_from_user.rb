class RemoveActcodeFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :actcode
  end

  def down
    add_column :users, :actcode, :string
  end
end
