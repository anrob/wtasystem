class AddActcodeIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :actcode_id, :integer
  end
end
