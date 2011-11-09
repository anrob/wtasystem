class ContractsController < ApplicationController
 load_and_authorize_resource
 respond_to :html, :xml, :json
 before_filter :everypage
 helper_method :themanager, :themap
    
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
   
   @h = LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType] = "column"
        f.options[:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
       f.series(:name=>'Contract Price', :data => @contract.map {|m|m.contract_price})
     end
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
    @unconfirmed = @contract.unconfirmedevent.thisweek.count + @contract.unconfirmedevent.tenday.count
    @unconfirmedcount = @unconfirmed
  else
    redirect_to root_url
  end
  end

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
      @contract = Contract.unconfirmedevent.actnet(:include => :users)
      #@user = User.find_by_actcode(:actcode).find(params[:actcode])
      #@contract_actcode = @contract
      #@useremail = User.mystuff(@user)
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
end
