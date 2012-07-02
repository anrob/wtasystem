# encoding: utf-8
class Contract < ActiveRecord::Base
  belongs_to :user
  has_one :actcode
  #has_many :users, :class_name => "Contract", :foreign_key => "actcode", :primary_key => 'act_code'
  default_scope :order => 'date_of_event ASC'
 #has_record_history

  
  scope :contractstatsus, :conditions => {:contract_status => ["Contract Received","Booked","Contract Sent", "Booked- PAY ACT","Complimentary","Promotional","Promo- WTA to pay"]}
  
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user)}
 
  scope :additional, ->(addi) { where("prntkey23 = ?", addi.prntkey23)} 
  scope :mytoday, -> {where("date_of_event >= ?", my_date)}
  scope :thisweek, -> {where(:date_of_event => (my_date)..(my_date + 7.days))}
  scope :justimported, where(:created_at => (my_date - 7.days)..(my_date))
  scope :tenday, -> {where(:date_of_event => (my_date)..(my_date + 10.days))}
  scope :thirtyday, where(:date_of_event => (my_date + 12.days)..(my_date + 30.days))
  scope :sixtyday, where(:date_of_event => (my_date )..(my_date + 60.days))
  scope :ninetyday, where(:date_of_event => (my_date)..(my_date + 90.days))
  scope :threesixfive, where(:date_of_event => (my_date - 120.days)..(my_date + 5.years))
  scope :confirmedevent, :conditions => {:confirmation => 1}
  scope :unconfirmedevent, where(:confirmation => "0")
  scope :innextten, where(:date_of_event => (my_date)..(my_date + 10.days))
  scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)}
  scope :getcount, lambda {|contra| 
    unconfirmedevent.where("act_code = ?", contra)}
  
 define_easy_dates do 
    format_for [:event_start_time, :event_end_time], :format => "%I:%M%P"
    format_for :date_of_event, :format => "%m/%d/%y"
  end

  def self.send_reminders
      @contracts = Contract.unconfirmedevent.contractstatsus.tenday.all
      @actcodes = Actcode.find_all_by_actcode(@contracts.map {|m|m.act_code})
      @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
      @u = @theusers.collect {|m| m.email}.uniq
      ContractMailer.send_user_reminder(@u).deliver
  end
  
  def self.send_user_reminders
      @contracts = Contract.unconfirmedevent.contractstatsus.tenday.all
      @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
      @userss = @users.collect {|m| m.email}.uniq
      ContractMailer.send_reminder(@userss).deliver
  end
  
  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
  
  def self.import_contracts
    #Contract.delete_all
   #   ActiveRecord::Base.connection.reset_pk_sequence!('Contract')
$KCODE = "U"
require 'csv'
require 'net/ftp'
Dir.chdir("#{Rails.root}/tmp") do
Net::FTP.open("ftp.dctalentphotovideo.com") do |ftp|
ftp.passive = true
ftp.login('telemagic@dctalentphotovideo.com', 'shaina99')
file = ftp.nlst("*.TXT")
file.each{|filename|ftp.getbinaryfile(filename,filename)}
                    @listit = Dir.glob("*.TXT")
                    @listit.each do |listit|
                   $KCODE = "UTF-8"   
                  CSV.foreach(listit, {:headers => true, :col_sep => "|", :force_quotes => true, :quote_char => "~", :converters => :date, encoding: "ISO8859-1"}) do |row|
                                                  @contracts = Contract.find_or_create_by_unique3(row[0])
                                                  @contracts.update_attributes( {
                                                   :unique3 => row[0],
                                                   :prntkey23 => row[1],
                                                   :prntkey13 => row[2],
                                                   :act_code => row[3],
                                                   :accounting_confirmation_date => row[4],
                                                   :act_form => row[5],
                                                   :act_net => row[6],
                                                   :agent => row[7],
                                                   :act_booked => row[8],
                                                   :credit_card_fee => row[9],
                                                   :ceremonoy_location_name => row[10],
                                                   :ceremonoy_address_line_1 => row[11],
                                                   :ceremony_address_line_2 => row[12],
                                                   :ceremony_location_city => row[13],
                                                   :ceremony_instrumenttation => row[14],
                                                   :seremonly_location_state => row[15],
                                                   :ceremony_location_zip => row[16],
                                                   :ceremony_start_time => row[17],
                                                   :ceremony_charge => row[18],
                                                   :cocktails_charge => row[19],
                                                   :early_setup_charge => row[20],
                                                   :early_setup_time => row[21],
                                                   :contract_price => row[22],
                                                   :charge_per_horn => row[23],
                                                   :other_charges => row[24],
                                                   :cocktail_instrumentation => row[25],
                                                   :cocktail_time => row[26],
                                                   :confirmation_date => row[27],
                                                   :contract_sent_date => row[28],
                                                   :contract_number => row[29],
                                                   :contract_revision_number => row[30],
                                                   :date_of_cancellation => row[31],
                                                   :date_of_ceremony => row[32],
                                                   :charge_per_dancer => row[33],
                                                   :number_of_dancers => row[34],
                                                   :giveaways => row[35],
                                                   :giveaways_charge => row[36],
                                                   :dj_tech_charge => row[37],
                                                   :tech => row[38],
                                                   :event_end_time => row[39],
                                                   :number_of_horns => row[40],
                                                   :type_of_light_show => row[41],
                                                   :location_name => row[42].inspect,
                                                   :location_address_line_1 => row[43],
                                                   :location_address_line_2 => row[44],
                                                   :location_city => row[45],
                                                   :location_state => row[46],
                                                   :location_zip => row[47],
                                                   :location_phone => row[48],
                                                   :non_commissionable_charges => row[49],
                                                   :pick_up_amount => row[50],
                                                   :explanation_opf_pickup_adjustment => row[51],
                                                   :capital_music_player => row[52],
                                                   :capital_music_pay => row[53],
                                                   :base_price_of_act => row[54],
                                                   :questionnaire_received_date => row[55],
                                                   :questionnaire_sent_date => row[56],
                                                   :referral_fee_amount => row[57],
                                                   :referral_fee_to => row[58],
                                                   :song_requests => row[59],
                                                   :event_start_time => row[60],
                                                   :contract_status => row[61],
                                                   :tax_amount => row[62],
                                                   :type_of_act => row[63],
                                                   :type_of_event => row[64],
                                                   :videographer_1 => row[65],
                                                   :videographer_2 => row[66],
                                                   :videgrapher_3 => row[67],
                                                   :date_of_event => Date.strptime(row[68], "%m/%d/%Y").to_s(:db),
                                                   :first_name => row[69],
                                                   :last_name => row[70],
                                                   :email_address => row[71],
                                                   :company => row[72],
                                                   :brides_names => row[73],
                                                   :grooms_name => row[74],
                                                   :home_phone => row[75],
                                                   :work_phone => row[76],
                                                   :cell_phone => row[77], 
                                                   :party_planner => row[78],
                                                   :act_notes => row[79].inspect,
                                                   :contract_provisions => row[80].inspect,
                                                   :reception_location => row[81]}) 
                                                   FileUtils.mv (listit), ("#{Rails.root}/tmp/move")
                                                  end  
                                                end
                                        end
                                 end
                 Dir.chdir("../")          
     end
     
      
     
def self.mailchimp
    gb = Gibbon.new("5a302760393cea0667df7d02436e0090-us2")
    @contracts = Contract.contractstatsus
    @contracts.each do |us|
    gb.list_subscribe(:id => "6a120e7f17", :email_address => us.email_address,  :double_optin => false, :update_existing => true, :merge_vars => {:FNAME => us.first_name, :LNAME => us.last_name, :MERGE3 => us.date_of_event, :MMERGE4 => us.contract_status,  :ACTBOOKED => us.act_booked, :EVENTTYPE => us.type_of_event} )
    end
  end
  
 def eventtime
     "#{event_start_time} - #{event_end_time}"
   end
   
   def status
    if contract_status == "Contract Received"
      @status = "recieved"
    elsif contract_status == "Booked- PAY ACT"
      @status = "booked"
     else contract_status == "Hold"
        @status = "hold"
   end 
   @status
 end

end
