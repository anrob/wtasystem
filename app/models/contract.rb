# encoding: utf-8
class Contract < ActiveRecord::Base
  require 'chronic'
  belongs_to :user
  has_one :actcode
  #default_scope order: 'date_of_event DESC'
  attr_accessible :unique3,
 :prntkey23,
 :prntkey13,
 :act_code,
 :accounting_confirmation_date,
 :act_form,
 :act_net,
 :agent,
 :act_booked,
 :credit_card_fee,
 :ceremonoy_location_name,
 :ceremonoy_address_line_1,
 :ceremony_address_line_2,
 :ceremony_location_city,
 :ceremony_instrumenttation,
 :seremonly_location_state,
 :ceremony_location_zip,
 :ceremony_start_time,
 :ceremony_charge,
 :cocktails_charge,
 :early_setup_charge,
 :early_setup_time,
 :contract_price,
 :charge_per_horn,
 :other_charges,
 :cocktail_instrumentation,
 :cocktail_time,
 :confirmation_date,
 :contract_sent_date,
 :contract_number,
 :contract_revision_number,
 :date_of_cancellation,
 :date_of_ceremony,
 :charge_per_dancer,
 :number_of_dancers,
 :giveaways,
 :giveaways_charge,
 :dj_tech_charge,
 :tech,
 :event_end_time,
 :number_of_horns,
 :type_of_light_show,
 :location_name,
 :location_address_line_1,
 :location_address_line_2,
 :location_city,
 :location_state,
 :location_zip,
 :location_phone,
 :non_commissionable_charges,
 :pick_up_amount,
 :explanation_opf_pickup_adjustment,
 :capital_music_player,
 :capital_music_pay,
 :base_price_of_act,
 :questionnaire_received_date,
 :questionnaire_sent_date,
 :referral_fee_amount,
 :referral_fee_to,
 :song_requests,
 :event_start_time,
 :contract_status,
 :tax_amount,
 :type_of_act,
 :type_of_event,
 :videographer_1,
 :videographer_2,
 :videgrapher_3,
 :date_of_event,
 :first_name,
 :last_name,
 :email_address,
 :company,
 :brides_names,
 :grooms_name,
 :home_phone,
 :work_phone,
 :cell_phone,
 :party_planner,
 :act_notes,
 :contract_provisions,
 :confirmation,
 :reception_location,
 :longitude,
 :latitude

  default_scope  conditions: { contract_status: ["Contract Received","Booked","Contract Sent", "Booked- PAY ACT","Complimentary","Promotional","Promo- WTA to pay"]}
  Time.zone = "UTC"
  Chronic.time_class = Time.zone
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user)}
  scope :additional, ->(addi) { where("prntkey23 = ?", addi.prntkey23)}
  scope :mytoday, -> {where("date_of_event >= ?", my_date)}
  scope :thisweek, -> {where(date_of_event: (my_date)..(my_date + 7.days),:order => 'act_booked DESC')}
  scope :tenday, -> {where(date_of_event: (Chronic.parse("today"))..(Chronic.parse("10 days from now")))}
  scope :threesixfive, where(date_of_event:  (my_date - 120.days)..(my_date + 5.years))
  scope :remove, conditions: { contract_status: ["Cancelled", "Released"]}
  #scope :unconfirmedevent, where(confirmation: "0")
  #scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)}
  #scope :thirtyday, where(date_of_event: (my_date + 12.days)..(my_date + 30.days))

  define_easy_dates do
    format_for [:event_start_time, :event_end_time], format: "%I:%M%P"
    format_for [:date_of_event, :created_at], format: "%e %b"
  end

  def self.send_user_reminders
      @contracts = Contract.unconfirmedevent.tenday.all
      @actcodes = Actcode.find_all_by_actcode(@contracts.map {|m|m.act_code})
      @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
      @u = @theusers.collect {|m| m.email}.uniq
      ContractMailer.send_user_reminder(@u).deliver
  end

  def self.send_reminders
      @contracts = Contract.unconfirmedevent.tenday.all
      @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
      @userss = @users.collect {|m| m.email}.uniq
      ContractMailer.send_reminder(@userss).deliver
  end

  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
     mail( to: user.email,
           subject: "Your Event info")
  end

  def self.checkactcodes
        @allactcodes = Contract.all.collect { |obj| obj.act_code }.dups
        @actcodes = Actcode.all.collect { |b| b.name}
        @updates = @allactcodes - @actcodes
        unless @updates.empty?
        ContractMailer.newactcodes(@updates.inspect).deliver
        end

  end


def self.mailchimp
    gb = Gibbon.new("5a302760393cea0667df7d02436e0090-us2")
    @contracts = Contract.all
    @contracts.each do |us|
    gb.list_subscribe(id: "6a120e7f17", email_address: us.email_address,  double_optin: false, update_existing: true, merge_vars: {FNAME: us.first_name, LNAME: us.last_name, MERGE3: us.date_of_event, MMERGE4:  us.contract_status,  ACTBOOKED:  us.act_booked, EVENTTYPE: us.type_of_event} )
    end
  end

 def eventtime
     "#{event_start_time} - #{event_end_time}"
   end

 #   def eventdatetime
 #     "#{date_of_event}".strftime('%Y%m%d')+"{event_start_time}".strftime('T%H%M%S')}
 #   end
 # #
 #   def status
 #    if contract_status == "Contract Received"
 #      @status = "recieved"
 #    elsif contract_status == "Booked- PAY ACT"
 #      @status = "booked"
 #     else contract_status == "Hold"
 #        @status = "hold"
 #   end
 #   @status
 # end



end
