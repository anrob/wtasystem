# RailsAdmin config file. Generated on February 23, 2012 03:32
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated
  
  # If you want to track changes on your models:
  # config.audit_with :history, User
  
  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User
  
  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Wtasystem', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Actcode, Contract, Management, Message, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Actcode, Contract, Management, Message, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Actcode do
  #   # Found associations:
  #     configure :management, :belongs_to_association 
  #     configure :users, :has_many_association 
  #     configure :contracts, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :actcode, :string 
  #     configure :management_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :description, :string 
  #     configure :user_id, :integer   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Contract do
  #   # Found associations:
  #     configure :actcode, :has_one_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :accounting_confirmation_date, :date 
  #     configure :act_form, :string 
  #     configure :act_net, :integer 
  #     configure :agent, :string 
  #     configure :act_booked, :string 
  #     configure :credit_card_fee, :integer 
  #     configure :ceremony_address_line_2, :string 
  #     configure :ceremony_location_city, :string 
  #     configure :ceremony_instrumenttation, :string 
  #     configure :ceremonoy_location_name, :string 
  #     configure :seremonly_location_state, :string 
  #     configure :ceremony_start_time, :string 
  #     configure :ceremony_location_zip, :string 
  #     configure :ceremony_charge, :integer 
  #     configure :cocktails_charge, :integer 
  #     configure :early_setup_charge, :integer 
  #     configure :contract_price, :integer 
  #     configure :charge_per_horn, :integer 
  #     configure :other_charges, :integer 
  #     configure :cocktail_instrumentation, :string 
  #     configure :confirmation_date, :date 
  #     configure :contract_sent_date, :date 
  #     configure :contract_number, :string 
  #     configure :contract_revision_number, :string 
  #     configure :date_of_cancellation, :date 
  #     configure :date_of_ceremony, :date 
  #     configure :charge_per_dancer, :integer 
  #     configure :number_of_dancers, :integer 
  #     configure :giveaways, :string 
  #     configure :giveaways_charge, :integer 
  #     configure :dj_tech_charge, :integer 
  #     configure :tech, :string 
  #     configure :event_end_time, :string 
  #     configure :early_setup_time, :string 
  #     configure :number_of_horns, :integer 
  #     configure :type_of_light_show, :string 
  #     configure :location_address_line_1, :string 
  #     configure :location_address_line_2, :string 
  #     configure :location_name, :string 
  #     configure :location_city, :string 
  #     configure :location_state, :string 
  #     configure :location_zip, :string 
  #     configure :non_commissionable_charges, :integer 
  #     configure :location_phone, :string 
  #     configure :pick_up_amount, :integer 
  #     configure :explanation_opf_pickup_adjustment, :string 
  #     configure :capital_music_player, :string 
  #     configure :capital_music_pay, :string 
  #     configure :base_price_of_act, :integer 
  #     configure :questionnaire_received_date, :date 
  #     configure :questionnaire_sent_date, :date 
  #     configure :referral_fee_amount, :integer 
  #     configure :referral_fee_to, :string 
  #     configure :song_requests, :string 
  #     configure :event_start_time, :string 
  #     configure :contract_status, :string 
  #     configure :tax_amount, :integer 
  #     configure :type_of_act, :string 
  #     configure :type_of_event, :string 
  #     configure :videographer_1, :string 
  #     configure :videographer_2, :string 
  #     configure :videgrapher_3, :string 
  #     configure :act_notes, :text 
  #     configure :contract_provisions, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :unique3, :string 
  #     configure :prntkey23, :string 
  #     configure :prntkey13, :string 
  #     configure :act_code, :string 
  #     configure :tmtable, :string 
  #     configure :party_planner, :string 
  #     configure :hours_of_coverage, :string 
  #     configure :unique_2, :string 
  #     configure :prntkey_2, :string 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :email_address, :string 
  #     configure :company, :string 
  #     configure :brides_names, :string 
  #     configure :grooms_name, :string 
  #     configure :home_phone, :string 
  #     configure :work_phone, :string 
  #     configure :cell_phone, :string 
  #     configure :date_of_event, :date 
  #     configure :confirmation, :integer 
  #     configure :ceremonoy_address_line_1, :string 
  #     configure :cocktail_time, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Management do
  #   # Found associations:
  #     configure :users, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :manageagement_code, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Message do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :received_messageable_id, :integer 
  #     configure :received_messageable_type, :string 
  #     configure :sender_id, :integer 
  #     configure :subject, :string 
  #     configure :body, :text 
  #     configure :opened, :boolean 
  #     configure :deleted, :boolean 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :management, :belongs_to_association 
  #     configure :actcode, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :roles_mask, :integer 
  #     configure :management_id, :integer         # Hidden 
  #     configure :manager, :boolean 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :phone_number, :string 
  #     configure :authentication_token, :string 
  #     configure :actcode_id, :integer         # Hidden 
  #     configure :rpx_identifier, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
