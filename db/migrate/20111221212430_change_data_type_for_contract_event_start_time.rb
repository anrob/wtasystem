class ChangeDataTypeForContractEventStartTime < ActiveRecord::Migration
  def self.up
    change_table :contracts do |t|
      t.change :event_start_time, :string
    end
  end

  def self.down
    change_table :contracts do |t|
    t.change :event_start_time, :time
  end
end
end
