class AddIndexToContract < ActiveRecord::Migration
  def change
    add_index :contracts, :unique3, :unique => true
  end
end
