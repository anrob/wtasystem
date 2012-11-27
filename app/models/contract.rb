# encoding: utf-8
class Contract < ActiveRecord::Base
  require 'chronic'
  has_one :actcode
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

 default_scope  conditions: { contract_status: ["Contract Received","Booked","Contract Sent", "Booked- PAY ACT","Complimentary","Promotional","Promo- WTA to pay"]},:order => ['confirmation ASC', 'date_of_event ASC']
  Time.zone = "UTC"
  Chronic.time_class = Time.zone
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user)}
  scope :additional, ->(addi) { where("prntkey23 = ?", addi.prntkey23)}
  scope :mytoday, -> {where("date_of_event >= ?", my_date)}
  scope :thisweek, -> {where(date_of_event: (my_date)..(my_date + 7.days),:order => 'act_booked DESC')}
  scope :fourday, -> {where(date_of_event: (Chronic.parse("today"))..(Chronic.parse("4 days from now")))}
  scope :nextsix, -> {where(date_of_event: (Chronic.parse("5 days from now"))..(Chronic.parse("10 days from now")))}
  scope :tenday, -> {where(date_of_event: (Chronic.parse("today"))..(Chronic.parse("10 days from now")))}
  scope :threesixfive, where(date_of_event:  (my_date - 120.days)..(my_date + 5.years))
  scope :remove, conditions: { contract_status: ["Cancelled", "Released"]}
  scope :unconfirmedevent, where(confirmation: "0")


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
            @allactcodes = Contract.all.collect { |obj| obj.act_code }
             @actcodes = User.all.collect { |b| b.actcode_name}
             @updates = @allactcodes - @actcodes

        unless @updates.empty?
        ContractMailer.newactcodes(@updates.uniq.inspect).deliver
        end
  end

  def self.notconfirmed
    #@notconfirmed = User.where('email != ?' ,"dummyemail").collect {|e| e.email}
    #@notconfirmed = User.where("management_id = ?", 1).collect {|ob| ob.email}
     @notconfirmed = User.where('confirmation_token IS NOT NULL' ).collect {|e| e.email}
      ContractMailer.notconfirmed(@notconfirmed).deliver
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

  scope :mitzvah, where("type_of_event LIKE ? OR type_of_event LIKE ? OR type_of_event LIKE ?", "Bar%", "Bat%", "B'n%")
  scope :wedding, where("type_of_event LIKE ? OR type_of_event LIKE ?", "Wedding%", " Wedding%")

  def is_wedding?
    type_of_event.start_with?("Wedding", " Wedding")
  end

  def is_mitzvah?
    type_of_event.start_with?("Bar", "Bat", "B'n")
  end

  before_create :send_welcome_email

  def send_welcome_email
    # check if status changed/set to booking
    valid_contract_statuses = ["Contract Received","Booked","Contract Sent", "Booked- PAY ACT","Complimentary","Promotional","Promo- WTA to pay","Hold- no dep."]
    if valid_contract_statuses.include?(self.contract_status)
      if !Contract.exists?(:email_address => self.email_address) # first time using washington talent
        # send Level 3 welcome email
        if is_wedding? || is_mitzvah?
          ContractMailer.welcome_to_family(self).deliver
        end
      end
    end
  end

  # following is the logic and scopes for sending emails at specific intervals
  scope :booked_2_weeks_ago,           where("date(created_at) = ?",    2.weeks.ago)
  scope :booked_1_month_ago,           where("date(created_at) = ?",    1.month.ago)
  scope :happening_1_year_from_now,    where("date(date_of_event) = ?", 1.year.from_now)
  scope :happening_10_months_from_now, where("date(date_of_event) = ?", 10.months.from_now)
  scope :happening_9_months_from_now,  where("date(date_of_event) = ?", 9.months.from_now)
  scope :happening_8_months_from_now,  where("date(date_of_event) = ?", 8.months.from_now)
  scope :happening_6_months_from_now,  where("date(date_of_event) = ?", 6.months.from_now)
  scope :happening_5_months_from_now,  where("date(date_of_event) = ?", 5.months.from_now)
  scope :happening_4_months_from_now,  where("date(date_of_event) = ?", 4.months.from_now)
  scope :happening_3_months_from_now,  where("date(date_of_event) = ?", 3.months.from_now)
  scope :happening_2_months_from_now,  where("date(date_of_event) = ?", 2.months.from_now)
  scope :happening_1_month_from_now,  where("date(date_of_event) = ?", 1.months.from_now)

  def self.send_mitzvah_emails

    self.mitzvah.booked_2_weeks_ago.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_photography).deliver
    end

    self.mitzvah.booked_1_month_ago.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_video).deliver
    end

    self.mitzvah.happening_1_year_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_green_screen).deliver #done
      ContractMailer.level_3_mail(c, :mitzvah_5p_kickback).deliver
    end

    self.mitzvah.happening_10_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_lighting).deliver
    end

    self.mitzvah.happening_9_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_photography).deliver
    end

    self.mitzvah.happening_8_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_photo_booth).deliver
    end

    self.mitzvah.happening_6_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_lighting).deliver
      ContractMailer.level_3_mail(c, :mitzvah_photography).deliver
    end

    self.mitzvah.happening_5_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_airbrush).deliver #done
    end

    self.mitzvah.happening_4_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_imagine_me).deliver #done
    end

    self.mitzvah.happening_3_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_sprockit_the_robot).deliver #done
    end

    self.mitzvah.happening_2_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_rocking_recording_booth).deliver #done
      ContractMailer.level_3_mail(c, :mitzvah_video).deliver
    end

    self.mitzvah.happening_1_month_from_now.each do |c|
      ContractMailer.level_3_mail(c, :mitzvah_lighting).deliver
    end

  end

  def self.send_wedding_emails

    self.wedding.booked_2_weeks_ago.each do |c|
      ContractMailer.level_3_mail(c, :wedding_photography).deliver
    end

    self.wedding.booked_1_month_ago.each do |c|
      ContractMailer.level_3_mail(c, :wedding_video).deliver
    end

    self.wedding.happening_1_year_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_5p_kickback).deliver
      ContractMailer.level_3_mail(c, :wedding_ceremony_musicians).deliver
    end

    self.wedding.happening_10_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_lighting).deliver
    end

    self.wedding.happening_9_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_photography).deliver
    end

    self.wedding.happening_8_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_photo_booth).deliver
    end

    self.wedding.happening_6_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_lighting).deliver
      ContractMailer.level_3_mail(c, :wedding_photography).deliver
    end

    self.wedding.happening_5_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_video).deliver
    end

    self.wedding.happening_4_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_photo_booth).deliver
    end

    self.wedding.happening_3_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_ceremony_musicians).deliver
    end

    self.wedding.happening_2_months_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_video).deliver
    end

    self.wedding.happening_1_month_from_now.each do |c|
      ContractMailer.level_3_mail(c, :wedding_lighting).deliver
    end

  end

end
