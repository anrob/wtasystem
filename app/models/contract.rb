class Contract < ActiveRecord::Base
  belongs_to :user
  #has_one :user
  #has_many :users, :class_name => "Contract", :foreign_key => "actcode", :primary_key => 'act_code'

  default_scope :order => 'date_of_event ASC'
  
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user.actcode)}
  scope :additional, lambda { |addi| where("prntkey23 = ?", addi.prntkey23)} 
  scope :mytoday, lambda { where("date_of_event >= ?", my_date)}
  scope :thisweek, where(:date_of_event => (my_date)..(my_date + 7.days))
  scope :tenday, where(:date_of_event => (my_date + 8.days)..(my_date + 11.days))
  scope :thirtyday, where(:date_of_event => (my_date + 12.days)..(my_date + 30.days))
  scope :sixtyday, where(:date_of_event => (my_date )..(my_date + 60.days))
  scope :ninetyday, where(:date_of_event => (my_date)..(my_date + 90.days))
  scope :threesixfive, where(:date_of_event => (my_date)..(my_date + 365.days))
  scope :confirmedevent, :conditions => {:confirmation => 1}
  scope :unconfirmedevent, where(:confirmation => 0)
  scope :innextten, where(:date_of_event => (my_date)..(my_date + 11.days))
  scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)}
  
 
 define_easy_dates do 
    format_for [:event_start_time, :event_end_time], :format => "%I:%M%P"
    format_for :date_of_event, :format => "%m/%d/%y"
  end
  
 
  
  def self.import_contracts
    $KCODE = "U"
        require 'csv'
        
        require 'net/ftp'
                Dir.chdir("#{Rails.root}/tmp") do
                        Net::FTP.open("ftp.dctalentphotovideo.com") do |ftp|
                          ftp.passive = true
                          ftp.login('telemagic@dctalentphotovideo.com', 'shaina99')
                          file = ftp.nlst("*.TXTT")
                          file.each{|filename| #Loop through each element of the array
                          ftp.getbinaryfile(filename,filename) #Get the file
                          }
        @listit = Dir.glob("*.TXT")
        @listit.each do |listit|
       $KCODE = 'UTF8'   
      CSV.foreach(listit, {:headers => true, :col_sep => "|", :force_quotes => true, :quote_char => "~"}) do |row|
                                      @contracts = Contract.find_or_create_by_unique3(row[0])
                                      @contracts.update_attributes( {
                                       :unique3             =>  row[0],
                                       :prntkey23             =>  row[1],
                                       :prntkey13         =>  row[2],
                                       :act_code            =>  row[3],
                                       :agent       => row[7],
                                       :act_booked => row[8],
                                       :contract_number    => row[28],
                                       :type_of_event    => row[63],
                                       :date_of_event => Date.strptime(row[67], "%m/%d/%Y").to_s(:db),
                                       :first_name    => row[68],
                                       :last_name    => row[69],
                                       :location_name => row[41],
                                       :act_notes => row[77].inspect,
                                       :contract_provisions => row[78].inspect}) 
                                      end
                                    end
                                #FileUtils.rm Dir.glob('*.TXT')
                            end
                       end
     Dir.chdir("../")          
     end
     
     def self.send_reminders
        @contract = Contract.unconfirmedevent.innextten.includes(:user)
         @users = User.find_all_by_actcode(@contract.map {|m| m.act_code}) 
         @recipients = @users.collect {|m| m.email}
         @recipients_number = @users.collect {|m| m.phone_number}
         #ContractMailer.send_reminder(@recipients).deliver
         sms = Moonshado::Sms.new("#{@recipients_number}", "Your Have Events to confirm. Please log-in")
         sms.deliver_sms
     end
     
def self.mailchimp
    gb = Gibbon.new("5a302760393cea0667df7d02436e0090-us2")
    @users = User.all
    @users.each do |us|
    gb.list_subscribe(:id => "9e862a6c03", :email_address => us.email,  :double_optin => false, :update_existing => true, :merge_vars => {:FNAME => us.first_name, :LNAME => us.last_name, :MMERGE3 => us.updated_at } )
    end
  end
  
  def eventtime
     "#{event_start_time} #{event_end_time}"
   end
end


