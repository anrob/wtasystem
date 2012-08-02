# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120801122628) do

  create_table "actcodes", :force => true do |t|
    t.string   "actcode"
    t.integer  "management_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "user_id"
  end

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "actnotes", :force => true do |t|
    t.string   "uniquekey"
    t.text     "contract_provisions"
    t.text     "act_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confirmations", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "user_id"
    t.integer  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.string   "accounting_confirmation_date"
    t.string   "act_form"
    t.integer  "act_net"
    t.string   "agent"
    t.string   "act_booked"
    t.integer  "credit_card_fee"
    t.string   "ceremony_address_line_2"
    t.string   "ceremony_location_city"
    t.string   "ceremony_instrumenttation"
    t.string   "ceremonoy_location_name"
    t.string   "seremonly_location_state"
    t.string   "ceremony_start_time"
    t.string   "ceremony_location_zip"
    t.integer  "ceremony_charge"
    t.integer  "cocktails_charge"
    t.integer  "early_setup_charge"
    t.integer  "contract_price"
    t.integer  "charge_per_horn"
    t.integer  "other_charges"
    t.string   "cocktail_instrumentation"
    t.string   "confirmation_date"
    t.string   "contract_sent_date"
    t.string   "contract_number"
    t.string   "contract_revision_number"
    t.string   "date_of_cancellation"
    t.string   "date_of_ceremony"
    t.integer  "charge_per_dancer"
    t.integer  "number_of_dancers"
    t.string   "giveaways"
    t.integer  "giveaways_charge"
    t.integer  "dj_tech_charge"
    t.string   "tech"
    t.string   "event_end_time"
    t.string   "early_setup_time"
    t.integer  "number_of_horns"
    t.string   "type_of_light_show"
    t.string   "location_address_line_1"
    t.string   "location_address_line_2"
    t.string   "location_name"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.integer  "non_commissionable_charges"
    t.string   "location_phone"
    t.integer  "pick_up_amount"
    t.string   "explanation_opf_pickup_adjustment"
    t.string   "capital_music_player"
    t.string   "capital_music_pay"
    t.integer  "base_price_of_act"
    t.date     "questionnaire_received_date"
    t.date     "questionnaire_sent_date"
    t.integer  "referral_fee_amount"
    t.string   "referral_fee_to"
    t.string   "song_requests"
    t.string   "event_start_time"
    t.string   "contract_status"
    t.integer  "tax_amount"
    t.string   "type_of_act"
    t.string   "type_of_event"
    t.string   "videographer_1"
    t.string   "videographer_2"
    t.string   "videgrapher_3"
    t.text     "act_notes"
    t.text     "contract_provisions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unique3"
    t.string   "prntkey23"
    t.string   "prntkey13"
    t.string   "act_code"
    t.string   "tmtable"
    t.string   "party_planner"
    t.string   "hours_of_coverage"
    t.string   "unique_2"
    t.string   "prntkey_2"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.string   "company"
    t.string   "brides_names"
    t.string   "grooms_name"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "cell_phone"
    t.date     "date_of_event"
    t.integer  "confirmation",                      :default => 0
    t.string   "ceremonoy_address_line_1"
    t.string   "cocktail_time"
    t.string   "reception_location"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managements", :force => true do |t|
    t.string   "name"
    t.string   "manageagement_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "sent_messageable_id"
    t.string   "sent_messageable_type"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_copies", ["sent_messageable_id", "recipient_id"], :name => "outbox_idx"

  create_table "messages", :force => true do |t|
    t.integer  "received_messageable_id"
    t.string   "received_messageable_type"
    t.integer  "sender_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "opened",                    :default => false
    t.boolean  "deleted",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["received_messageable_id", "sender_id"], :name => "inbox_idx"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.date     "date_of_event"
    t.time     "event_start_time"
    t.time     "event_end_time"
    t.string   "act_form"
    t.string   "agent"
    t.integer  "actcode_id"
    t.integer  "client_id"
    t.string   "credit_card_fee"
    t.string   "reception_location"
    t.string   "cocktails_charge"
    t.string   "early_setup_charge"
    t.time     "early_setup_time"
    t.string   "contract_price"
    t.string   "charge_per_horn"
    t.string   "other_charges"
    t.string   "cocktail_instrumentation"
    t.time     "cocktail_time"
    t.date     "confirmation_date"
    t.string   "contract_sent_date"
    t.date     "date_of_ceremony"
    t.string   "charge_per_dancer"
    t.string   "number_of_dancers"
    t.string   "giveaways"
    t.string   "giveaways_charge"
    t.string   "dj_tech_charge"
    t.string   "tech"
    t.string   "number_of_horns"
    t.string   "type_of_light_show"
    t.integer  "location_id"
    t.string   "base_price_of_act"
    t.string   "contract_status"
    t.string   "type_of_act"
    t.string   "type_of_event"
    t.boolean  "party_planner"
    t.text     "act_notes"
    t.text     "contract_provisions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "record_histories", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "attr_name"
    t.text     "old_value_dump"
    t.text     "new_value_dump"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.decimal  "transaction_id", :null => false
  end

  add_index "record_histories", ["author_type", "author_id"], :name => "index_record_histories_on_author_type_and_author_id"
  add_index "record_histories", ["item_type", "item_id", "attr_name"], :name => "index_record_histories_on_item_type_and_item_id_and_attr_name"
  add_index "record_histories", ["item_type", "item_id"], :name => "index_record_histories_on_item_type_and_item_id"
  add_index "record_histories", ["transaction_id"], :name => "index_record_histories_on_transaction_id"

  create_table "specs", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.integer  "management_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.integer  "management_id"
    t.boolean  "manager",                               :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "authentication_token"
    t.string   "rpx_identifier"
    t.string   "actcode_name"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
  end

end
