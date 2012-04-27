# -*- encoding : utf-8 -*-
class CreateActcodes < ActiveRecord::Migration
  def change
    create_table :actcodes do |t|
      t.string :actcode
      t.integer :management_id

      t.timestamps
    end
  end
end
