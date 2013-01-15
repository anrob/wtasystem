class AddEmailRemoveToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :unsubscrib, :boolean
    add_column :contracts, :player4, :string
    add_column :contracts, :player5, :string
    add_column :contracts, :player6, :string
    add_column :contracts, :player7, :string
    add_column :contracts, :player8, :string
  end
end
