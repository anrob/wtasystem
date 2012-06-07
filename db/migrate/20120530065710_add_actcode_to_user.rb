class AddActcodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :actcode_name, :string
  end
end
