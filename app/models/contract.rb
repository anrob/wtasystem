class Contract < ActiveRecord::Base
  belongs_to :user
  has_one :actcode
  #has_many :users, :class_name => "Contract", :foreign_key => "actcode", :primary_key => 'act_code'

  default_scope :order => 'date_of_event ASC'
  
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user)}
 
  scope :additional, lambda { |addi| where("prntkey23 = ?", addi.prntkey23)} 
  scope :mytoday, lambda { where("date_of_event >= ?", my_date)}
  scope :thisweek, where(:date_of_event => (my_date)..(my_date + 7.days))
  scope :justimported, where(:created_at => (my_date - 7.days)..(my_date))
  scope :tenday, where(:date_of_event => (my_date)..(my_date + 11.days))
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
  
  # def deliver(user, contract, additional)
  #   event_info_email(user, contract, additional)
  #   handle_asynchronously :deliver
  # end
  def self.send_reminders
      # @contract = Contract.unconfirmedevent.innextten.includes(:user)
      #    @users = User.find_all_by_actcode(@contract.map {|m| m.act_code}) 
      @contract = Contract.unconfirmedevent.innextten.includes(:user)
      @actcodes = Actcode.find_all_by_actcode(@contract.map {|m| m.act_code})
      @users = User.find_all_by_actcode_id(@actcodes) 
      @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
      @recipients = @theusers.collect {|m| m.email}
      @recipients_number = @theusers.collect {|m| m.phone_number}
     ContractMailer.send_reminder(@recipients).deliver
    # @recipients_number.compact.each do |phonenumber|
    #   sms = Moonshado::Sms.new(phonenumber, "Your Have Events to confirm. Please log-in to http://wtav1.herokuapp.com to confirm")
    #  sms.deliver_sms
    #end
  end
  
  def event_info_email(user, contract, additional)
      @user = user
      @contract = contract
      @additional = additional
     mail( :to => user.email, 
           :subject => "Your Event info")
   end
  
  def self.import_contracts
    Contract.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('Contract')
   # ActiveRecord::Base.connection.tables.each do |table| 
   #        ActiveRecord::Base.connection.execute("TRUNCATE #{table}") 
   #    end
    $KCODE = "U"
                    require 'csv'
                    
                    require 'net/ftp'
                            Dir.chdir("#{Rails.root}/tmp") do
                                    Net::FTP.open("ftp.dctalentphotovideo.com") do |ftp|
                                                                                                       ftp.passive = true
                                                                                                       ftp.login('telemagic@dctalentphotovideo.com', 'shaina99')
                                                                                                       file = ftp.nlst("*.TXT")
                                                                                                       file.each{|filename| #Loop through each element of the array
                                                                                                       ftp.getbinaryfile(filename,filename) #Get the file
                                                                                                        }
                    @listit = Dir.glob("*.TXT")
                    @listit.each do |listit|
                   $KCODE = 'UTF8'   
                  CSV.foreach(listit, {:headers => true, :col_sep => "|", :force_quotes => true, :quote_char => "~"}) do |row|
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
                                                   :confirmation_date => row[26],
                                                   :contract_sent_date => row[27],
                                                   :contract_number => row[28],
                                                   :contract_revision_number => row[29],
                                                   :date_of_cancellation => row[30],
                                                   :date_of_ceremony => row[31],
                                                   :charge_per_dancer => row[32],
                                                   :number_of_dancers => row[33],
                                                   :giveaways => row[34],
                                                   :giveaways_charge => row[35],
                                                   :dj_tech_charge => row[36],
                                                   :tech => row[37],
                                                   :event_end_time => row[38],
                                                   :number_of_horns => row[39],
                                                   :type_of_light_show => row[40],
                                                   :location_name => row[41].inspect,
                                                   :location_address_line_1 => row[42],
                                                   :location_address_line_2 => row[43],
                                                   :location_city => row[44],
                                                   :location_state => row[45],
                                                   :location_zip => row[46],
                                                   :location_phone => row[47],
                                                   :non_commissionable_charges => row[48],
                                                   :pick_up_amount => row[49],
                                                   :explanation_opf_pickup_adjustment => row[50],
                                                   :capital_music_player => row[51],
                                                   :capital_music_pay => row[52],
                                                   :base_price_of_act => row[53],
                                                   :questionnaire_received_date => row[54],
                                                   :questionnaire_sent_date => row[55],
                                                   :referral_fee_amount => row[56],
                                                   :referral_fee_to => row[57],
                                                   :song_requests => row[58],
                                                   :event_start_time => row[59],
                                                   :contract_status => row[60],
                                                   :tax_amount => row[61],
                                                   :type_of_act => row[62],
                                                   :type_of_event => row[63],
                                                   :videographer_1 => row[64],
                                                   :videographer_2 => row[65],
                                                   :videgrapher_3 => row[66],
                                                   :date_of_event => Date.strptime(row[67], "%m/%d/%Y").to_s(:db),
                                                   :first_name => row[68],
                                                   :last_name => row[69],
                                                   :email_address => row[70],
                                                   :company => row[71],
                                                   :brides_names => row[72],
                                                   :grooms_name => row[73],
                                                   :home_phone => row[74],
                                                   :work_phone => row[75],
                                                   :cell_phone => row[76], 
                                                   :act_notes => row[77].inspect,
                                                   :contract_provisions => row[78].inspect}) 
                                                  end
                                                end
                                            FileUtils.rm Dir.glob('*.TXT')
                                        end
                                  end
                 Dir.chdir("../")          
     end
     
     # def self.send_reminders
     #       # @contract = Contract.unconfirmedevent.innextten.includes(:user)
     #       #    @users = User.find_all_by_actcode(@contract.map {|m| m.act_code}) 
     #       @contract = Contract.unconfirmedevent.innextten.includes(:user)
     #       @actcodes = Actcode.find_all_by_actcode(@contract.map {|m| m.act_code})
     #       @users = User.find_all_by_actcode_id(@actcodes) 
     #       @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
     #       @recipients = @users.collect {|m| m.email}
     #       @recipients_number = @theusers.collect {|m| m.phone_number}
     #      ContractMailer.send_reminder(@recipients).deliver
     #     # @recipients_number.compact.each do |phonenumber|
     #    #   sms = Moonshado::Sms.new(phonenumber, "Your Have Events to confirm. Please log-in to http://wtav1.herokuapp.com to confirm")
     #     #  sms.deliver_sms
     #    
     #      
     # 
     #   #end
     #   end
     
def self.mailchimp
    gb = Gibbon.new("5a302760393cea0667df7d02436e0090-us2")
    @users = User.all
    @users.each do |us|
    gb.list_subscribe(:id => "9e862a6c03", :email_address => us.email,  :double_optin => false, :update_existing => true, :merge_vars => {:FNAME => us.first_name, :LNAME => us.last_name, :MMERGE3 => us.updated_at } )
    end
  end
  
  def isincluded
  
   unless @contract.nil?
      @isinclud = "normal"
    else
      @isinclud = "bold"
    end
    @isinclud

  end
  
  def eventtime
     "#{event_start_time} #{event_end_time}"
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


