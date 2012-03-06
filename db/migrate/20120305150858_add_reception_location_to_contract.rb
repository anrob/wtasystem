class AddReceptionLocationToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :reception_location, :string
  end
end
