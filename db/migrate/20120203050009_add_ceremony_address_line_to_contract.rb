class AddCeremonyAddressLineToContract < ActiveRecord::Migration
  def change
    add_column :contracts, :ceremonoy_address_line_1, :string
  end
end
