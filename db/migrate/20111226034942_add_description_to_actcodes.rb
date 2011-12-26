class AddDescriptionToActcodes < ActiveRecord::Migration
  def change
    add_column :actcodes, :description, :string
  end
end
