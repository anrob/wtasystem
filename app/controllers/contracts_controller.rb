class ContractsController < ApplicationController
 set_tab :home
 inherit_resources
 load_and_authorize_resource
 before_filter :everypage
 helper_method :themanager, :themap
    
  def index 
    case @but when "true"
        @contract = Contract.where(:act_code => params[:act_code])
        @actcode = Actcode.where(:actcode => params[:act_code]).first
        @unconfirmed = Contract.count
        @totalcount = @contract.count
        
        if cannot? :see_others, @contract
                   redirect_to root_url
        end
        else
          #@mana = Actcode.find_by_id(current_user.actcode_id)
                        @contract = Contract.mytoday.mystuff(@mana.actcode)
                        @actcode = current_user.actcode
                        @getcompan = Actcode.getallbycompany(current_user)
                        @gt = Actcode.find_all_by_management_id(current_user.management_id)#.collect {|m| m.actcode} 
                        @cont = Contract.tenday.find_by_act_code(@gt.map {|m| m.actcode})
                        # @unconfirmed = Contract.includes("actcodes").where(:act_code => params[:act_code]).count
                        @unconfirmed = Contract.count
                        @gp = @gt.map {|m| m.actcode}
                            @totalcount = @contract.threesixfive.count
                            @totalnum = @contract.threesixfive.sum(:contract_price)
      end 
     #respond_with :contracts => @contract.thisweek
 end

  def show
      add_breadcrumb "Show Contract", contract_path
      @additional = Contract.additional(@contract)
      respond_with do |format|
            format.html
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
      unless current_user.is? :manager
       @contracts = Contract.mystuff(@user.actcode.actcode).threesixfive.all  
      else
         @contracts = Contract.where(:act_code => @manger.split(",")).threesixfive.all
        end
      respond_with :contracts => @contracts
  end
  def alljobs
        @noactcode = Contract.justimported
       @contract = Contract.unconfirmedevent.innextten.includes(:user)
       @actcodes = Actcode.find_all_by_actcode(@contract.map {|m| m.act_code})
       @users = User.find_all_by_actcode_id(@actcodes) 
       @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
       @recipients = @theusers.collect {|m| m.email}
    
  end
  
  def confirmjob
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    ContractMailer.deliver(@user,@contract,@additional)
    #ContractMailer.delay.deliver(mail_hash)
    #@contract.update_attributes(:confirmation => 1)
    flash[:notice] = "Job Confirmed"
      redirect_to :back
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
