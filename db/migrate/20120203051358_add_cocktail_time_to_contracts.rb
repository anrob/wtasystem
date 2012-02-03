class AddCocktailTimeToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :cocktail_time, :string
    #add_column :contracts, :party_planner, :string
  end
end
