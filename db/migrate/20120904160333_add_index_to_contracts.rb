class AddIndexToContracts < ActiveRecord::Migration
  def self.up
      add_index :contracts, :unique3, :unique => true
    end

    def self.down
      remove_index :contracts, :column => :unique3
    end
end
