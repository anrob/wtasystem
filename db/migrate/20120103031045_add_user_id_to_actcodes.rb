# -*- encoding : utf-8 -*-
class AddUserIdToActcodes < ActiveRecord::Migration
  def change
    add_column :actcodes, :user_id, :integer
  end
end
