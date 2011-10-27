class ContractsController < ApplicationController
 load_and_authorize_resource
respond_to :html, :xml, :json
 before_filter :everypage
    
  def index
   @user = current_user
   @contracts = Contract.mytoday.mystuff(current_user)
   @contract_month = @contracts.group_by { |t| t.date_of_event.beginning_of_month }
   @unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
   @unconfirmedcount = @unconfirmed
   @otheracts = User.getotheracts(current_user)
   @co = @otheracts.collect(&:actcode)
   @cd = Contract.mytoday.where(:act_code => @co).sum(:contract_price)
   @@cother = User.where(@user)
   @pd = @user
   @managements = Management.find_by_id(current_user.management_id)
   @message = Message.last
   @cc = @contracts.mytoday.sum(:contract_price)
   @cp = Contract.where(:act_code => current_user.actcode)
   @test = @cp.mytoday.count
   # respond_to do |format|
   #        format.html # index.html.erb
   #        format.xml  { render :xml => @contracts.thirtyday }
   #        format.json { render :json => @contracts.thirtyday }
   #   end
  end
 
  def otheracts
    @otheracts = User.getotheracts(current_user)
    if User.getotheracts(current_user)
    @contracts = Contract.where(:act_code => params[:act_code])
    @unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
    @unconfirmedcount = @unconfirmed
    @cother = User.where(:actcode => params[:act_code])
    @pd = User.find_by_actcode(params[:act_code])
    @cc = @contracts.mytoday.sum(:contract_price) 
    @test = @contracts.mytoday.count
    add_breadcrumb "Other Acts", otheracts_path, :title => "Back to Index"
  else
    flash[:error] = "Access denied."
    redirect_to root_url
    end
   
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    add_breadcrumb "Show Contract", contract_path
    #@contracts = Contract.mytoday.mystuff(current_user)
    #@unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
    #@unconfirmedcount = @unconfirmed
    if can? :everything, Contract
    @contract = Contract.find(params[:id])
  else
    @otheracts = User.find(params[current_user.management_id])
    @contract = @otheracts.contract.find(params[:id])
  end
    @additional = Contract.additional(@contract)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
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
                      
      #Dir.chdir(Rails.root + "tmp")
      #@thedir = Dir.getwd
      @listit = Dir.glob("*.TXT")
      
      @listit.each do |listit|
      #filename = "000075.TXT"
      CSV.foreach(listit, {:headers => true, :col_sep => "|", :force_quotes => true, :quote_char => "~"}) do |row|
                                      @contracts = Contract.find_or_create_by_unique3(row[0])
                                      @contracts.update_attributes({ 
                                       :unique3             =>  row[0],
                                       :prntkey23             =>  row[1],
                                       :prntkey13         =>  row[2],
                                       :act_code            =>  row[3],
                                       :agent       => row[7],
                                       :act_booked => row[8],
                                       :contract_number    => row[28],
                                       :type_of_event    => row[63],
                                       :date_of_event    => row[67],
                                       :first_name    => row[68],
                                       :last_name    => row[69] }
                                      ) 
                                      end
                                    end
                                    FileUtils.rm Dir.glob('*.TXT')
                                 end
                       end
      #           # Dir.chdir("../")          
      #         redirect_to :root
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
end
