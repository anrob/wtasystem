class Contract < ActiveRecord::Base
  
  belongs_to :user
  default_scope :order => 'date_of_event ASC'
  #default_scope :actorder => 'act_code ASC'
  my_date = Date.today
  scope :mystuff, lambda { |user| where("act_code = ?", user.actcode)}
  scope :additional, lambda { |addi| where("prntkey23 = ?", addi.prntkey23)}
  scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)} 
  scope :mytoday, lambda { where("date_of_event >= ?", my_date)}
  scope :thisweek, where(:date_of_event => (my_date)..(my_date + 7.days))
  scope :tenday, where(:date_of_event => (my_date + 8.days)..(my_date + 11.days))
  scope :thirtyday, where(:date_of_event => (my_date + 11.days)..(my_date + 30.days))
  scope :sixtyday, where(:date_of_event => (my_date )..(my_date + 60.days))
  scope :ninetyday, where(:date_of_event => (my_date)..(my_date + 365.days))
  scope :confirmedevent, :conditions => {:confirmation => 1}
  scope :unconfirmedevent, where(:confirmation => 0)
  scope :actnet, where(:date_of_event => (my_date)..(my_date + 30.days))
 
 def self.total_on(month)
   where("date(date_of_event) = ?", month).sum(:contract_price)
 end
 
 define_easy_dates do 
    format_for [:event_start_time, :event_end_time], :format => "%I:%M%P"
    format_for :date_of_event, :format => "%m/%d/%y"
  end
  
end
