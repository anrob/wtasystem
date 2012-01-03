class ContractsController < ApplicationController
 #load_and_authorize_resource
 set_tab :home
 before_filter :everypage
 helper_method :themanager, :themap
    
  def index 
    case @but when "true"
    @contract = Contract.where(:act_code => params[:act_code])
    if cannot? :see_others, @contract
     redirect_to root_url
    end
    else
      @mana = Actcode.find_by_id(current_user.actcode_id)
      @contract = Contract.mytoday.mystuff(@mana.actcode)
  # @contract_count = Contract.where(:act_code => params[@getallbycompnay]).count
  #  @c = @getallbycompnay.each do |actcodeee|
  #  # Contract.where(:act_code => actcodeee.actcode).thirtyday.count
  #  # Contract.getcount(actcodeee.actcode).thirtyday.count
  #  @d = Contract.find_all_by_act_code(actcodeee.actcode)
  #  @e = @d.count
  # end
    # end
      @unconfirmed = @contract.unconfirmedevent.thisweek.count + @contract.unconfirmedevent.tenday.count
      
    end 
 #respond_with :contracts => @contract.thisweek
 end

  def show
      add_breadcrumb "Show Contract", contract_path
      @contract = Contract.find(params[:id])
      if @contract.act_code = current_user.actcode
      @ismanager = @manger.include?(@contract.act_code).to_s
    end
      case @ismanager when "true"
     if cannot? :see_others, @contract
      redirect_to root_url        
      end
    else
       @contract = Contract.find(params[:id])
    end
      @additional = Contract.additional(@contract)
      respond_with do |format|
        # format.html
        format.pdf do
        pdf = ContractPdf.new(@contract, view_context)
        send_data pdf.render, filename: "contract_#{@contract.contract_number}.pdf",
        
        type: "application/pdf",
        disposition: "inline"
      end
    end
 
  end
  
  def calendar
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @mana = Actcode.find_by_id(current_user.actcode_id)
      #case @but when "true"
      unless can? :see_others, Contract
       @contracts = Contract.mystuff(@user.actcode.actcode).threesixfive.all  
      else
         @contracts = Contract.where(:act_code => @manger.split(",")).threesixfive.all
        end
      respond_with :contracts => @contracts
  end
  def alljobs
       @contract = Contract.unconfirmedevent.innextten.includes(:user)
       @actcodes = Actcode.find_all_by_actcode(@contract.map {|m| m.act_code})
       @users = User.find_all_by_management_id(@actcodes.map {|m| m.management_id}) 
       # @confirmed User.where(:confirmation => )
       @recipients = @users.collect {|m| m.email}
     # @contract = Contract.mystuff(@mana.actcode).ninetyday
  end
  
  def confirmjob
    #@user = current_user
    #@management = Management.find_by_id(current_user)
    @contract = Contract.find(params[:id])
    @contract.update_attributes(:confirmation => 1)
    #ContractMailer.event_info_email(@user).deliver
    flash[:notice] = "Job Confirmed"
      redirect_to :root
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
  
  def themap
    "#{@contract.location_address_line_1}+#{@contract.location_city}+#{@contract.location_state}+#{@contract.location_zip}"
  end
  
  def gmail
    #require 'gmail'
    gmail = Gmail.connect("fresh@sofreshentertainment.com","shaina")
    @mailcount = gmail.inbox.find(:unread) do |email|
      email.read!
    end
    @maillabels = gmail.labels.all
    gmail.logout
  end
end
