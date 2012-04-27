# -*- encoding : utf-8 -*-
class ChangeDataTypesFroDateFields < ActiveRecord::Migration
  def up
    change_table :contracts do |t|
      t.change :accounting_confirmation_date, :string
      t.change :confirmation_date, :string
      t.change :contract_sent_date, :string
      t.change :date_of_cancellation, :string
      t.change :date_of_ceremony, :string
  end
end

  def down
    change_table :contracts do |t|
      t.change :accounting_confirmation_date, :date
      t.change :confirmation_date, :date
      t.change :contract_sent_date, :date
      t.change :date_of_cancellation, :date
      t.change :date_of_ceremony, :date
  end
end
end
