# -*- encoding : utf-8 -*-
class ChangeDataTypeTimeFields < ActiveRecord::Migration
  def up
    change_table :contracts do |t|
          t.change :ceremony_start_time, :string
           t.change :early_setup_time, :string
  end
end

  def down
    change_table :contracts do |t|
            t.change :ceremony_start_time, :date
              t.change :early_setup_time, :date
  end
end
end
