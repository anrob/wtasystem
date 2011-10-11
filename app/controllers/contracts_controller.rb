class ContractsController < ApplicationController
 load_and_authorize_resource
respond_to :html, :xml, :json
  def index
   @user = current_user
   @contracts = Contract.mytoday.mystuff(current_user)
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
    
    #@user = current_user
    
    @management = Management.find_by_id(current_user.management_id)
    @otheracts = User.getotheracts(current_user)
    if User.getotheracts(current_user)
    @contracts = Contract.where(:act_code => params[:act_code])
    @unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
     @unconfirmedcount = @unconfirmed
    @cother = User.where(:actcode => params[:act_code])
    @pd = @cother.first
    @cc = @contracts.mytoday.sum(:contract_price) 
    @test = @contracts.mytoday.count
    add_breadcrumb "Other Acts", otheracts_path, :title => "Back to Index"
    #@listact = User.find_by_id(params[:management_id])
  else
    flash[:error] = "Access denied."
    redirect_to root_url
    end
   
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    add_breadcrumb "Show Contract", contract_path
    @management = Management.find_by_id(current_user.management_id)
    @user = current_user
    @pd = @user
    @contracts = Contract.mytoday.mystuff(@user)
    @unconfirmed = @contracts.unconfirmedevent.thisweek.count + @contracts.unconfirmedevent.tenday.count
     @unconfirmedcount = @unconfirmed
     @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
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
end
