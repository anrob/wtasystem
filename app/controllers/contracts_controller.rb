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
 end 
 respond_with :contracts => @contract.thisweek
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
  end
 
 
  
  def calendar
      @date = params[:month] ? Date.parse(params[:month]) : Date.today
      @contracts = Contract.threesixfive.all
  end
  def alljobs
   
      @contract = Contract.mystuff(@mana.actcode).ninetyday
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
