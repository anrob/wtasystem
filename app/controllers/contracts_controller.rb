class ContractsController < ApplicationController
 load_and_authorize_resource
respond_to :html, :xml, :json
 before_filter :everypage
 helper_method :themanager
    
  def index
   @user = current_user
   @contract = Contract.mytoday.mystuff(current_user)
   @contract_month = @contract.group_by { |t| t.date_of_event.beginning_of_month }
   @unconfirmed = @contract.unconfirmedevent.thisweek.count + @contract.unconfirmedevent.tenday.count
   @unconfirmedcount = @unconfirmed
   @otheracts = User.getotheracts(current_user)
   @co = @otheracts.collect(&:actcode)
   @cd = Contract.mytoday.where(:act_code => @co).sum(:contract_price)
   @@cother = User.where(@user)
   @pd = @user
   @managements = Management.find_by_id(current_user.management_id)
   @message = Message.last
   @cc = @contract.mytoday.sum(:contract_price)
   @cp = Contract.where(:act_code => current_user.actcode)
   @test = @cp.mytoday.count
   respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @contract.thirtyday }
          format.json { render :json => @contract.ninetyday }
     end
  end
 
  def otheracts
    add_breadcrumb "Other Acts", otheracts_path, :title => "Back to Index"
      @manger = User.getotheracts(current_user).map {|m| m.actcode}
      @ismanager =  @manger.include?(params[:act_code]).to_s
      if @ismanager == "true"
    @otheracts = User.getotheracts(current_user)
    @contract = Contract.where(:act_code => params[:act_code])
    @unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
    @unconfirmedcount = @unconfirmed
  else
    redirect_to root_url
  end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
      add_breadcrumb "Show Contract", contract_path
      if can? :see_others, Contract
      themanager 
    else
      @contract = Contract.mystuff(current_user).find(params[:id])
      @additional = Contract.additional(@contract)
    end
    
end
  
  def calendar
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @contracts = Contract.threesixfive.all
  end
  def alljobs
      @contracts = Contract.unconfirmedevent.actnet.all
  end
  
  def confirmjob
    @user = current_user
    @management = Management.find_by_id(current_user)
    @contract = Contract.find(params[:id])
    @contract.update_attributes(:confirmation => 1)
    ContractMailer.event_info_email(@user).deliver
    flash[:notice] = "Job Confirmed"
      redirect_to :root
   end
   
   def import_contracts
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
                        
        
        #@thedir = Dir.getwd
        @listit = Dir.glob("*.TXT")
        
        @listit.each do |listit|
       # Dir.chdir(Rails.root + "tmp")
      #listit = "000076.TXT"
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
                                       :location_name => row[41]}) 
                                      end
                                    end
                                FileUtils.rm Dir.glob('*.TXT')
                            end
                       end
     Dir.chdir("../")          
     end
  
     def mailchimp
      gb = Gibbon.new("5a302760393cea0667df7d02436e0090-us2") 
      #@gblist = gb.lists({:start => 0, :limit=> 100})
      #gb = gb.listMemberInfo({:id => "9e862a6c03", :email_address => "fresh@sofreshentertainment.com"})
      @users = User.all
      @users.each do |us|
        gb.list_subscribe(:id => "9e862a6c03", :email_address => us.email,  :double_optin => false, :update_existing => true, :merge_vars => {:FNAME => us.first_name, :LNAME => us.last_name, :MMERGE3 => us.updated_at } )
        
     # gb.list_batch_subscribe(:id => "9e862a6c03", :email_address => us.email, :merge_vars => {:FNAME => us.actcode, :MMERGE3 => us.updated_at } )
    end
  end
  
 
  def themanager
        @manger = User.getotheracts(current_user).map {|m| m.actcode}
        @ismanager = @manger.include?(@contract.act_code).to_s
        @additional = Contract.additional(@contract)
        if @ismanager == "true"
        @contract = Contract.find(params[:id])
      else
         @contract = Contract.mystuff(current_user).find(params[:id])
      end
  end
end
