# -*- encoding : utf-8 -*-
class AddReceptionLocationToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :reception_location, :string
  end
end
