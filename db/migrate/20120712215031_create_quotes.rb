class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.date :date_of_event
      t.time :event_start_time
      t.time :event_end_time
      t.string :act_form
      t.string :agent
      t.integer :actcode_id
      t.integer :client_id
      t.string :credit_card_fee
      t.string :reception_location
      t.string :cocktails_charge
      t.string :early_setup_charge
      t.time :early_setup_time
      t.string :contract_price
      t.string :charge_per_horn
      t.string :other_charges
      t.string :cocktail_instrumentation
      t.time :cocktail_time
      t.date :confirmation_date
      t.string :contract_sent_date
      t.date :date_of_ceremony
      t.string :charge_per_dancer
      t.string :number_of_dancers
      t.string :giveaways
      t.string :giveaways_charge
      t.string :dj_tech_charge
      t.string :tech
      t.string :number_of_horns
      t.string :type_of_light_show
      t.integer :location_id
      t.string :base_price_of_act
      t.string :contract_status
      t.string :type_of_act
      t.string :type_of_event
      t.boolean :party_planner
      t.text :act_notes
      t.text :contract_provisions

      t.timestamps
    end
  end
end
