class RemoveActcodeIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :actcode_id
  end

  def down
    add_column :users, :actcode_id, :integer
  end
end
