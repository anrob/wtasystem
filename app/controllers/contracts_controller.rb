# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
  set_tab :home
  inherit_resources
  load_and_authorize_resource
  before_filter :everypage
  before_filter :find_contract, :only => [:confirmjob, :emailjobwithnetonly, :emailjobwithallmoney, :emailjobnomoney]
  helper_method :themanager, :themap
<<<<<<< HEAD
layout "home", :except => [:index]

=======
  layout "home"
>>>>>>> newlook

  def index
    @contract = Contract.where(act_code: params[:act_code])
    #@contract = @contractstart.order(params[:sort])
    @contracts = Contract.mystuff(current_user.actcode_name).order(params[:sort] || :date_of_event).tenday.all
    #@contracts = @contractend.order(params[:sort])

  end

  def show
    @additional = Contract.additional(@contract)
<<<<<<< HEAD
     @versions = Version.where(item_id: params[:id])
=======
    @versions = Version.where(item_id: params[:id])
>>>>>>> newlook
  end

  def calendar
    #@search = Contract.search(params[:search])
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    unless current_user.is? :manager
      @contracts = Contract.mystuff(@current_user.actcode_name).threesixfive.all
    else
      @contracts = Contract.where(act_code: @manger.split(",")).threesixfive.all

    end
    respond_with contracts: @contracts
  end


  def alljobs
    if current_user.is? :everything
      @contractfour = Contract.order(params[:sort]).tenday.all
      #@contracts = Contract.where(act_code: params[:act_code])
      #@contracts = Contract.order(params[:sort]).nextsix.all
      #@contractbymonth = @contracts.group_by { |t| t.date_of_event.beginning_of_week}
      #@allactcodes = Contract.all.collect { |obj| obj.act_code }
      #@actcodes = Actcode.all.collect { |b| b.name}
      #@updates = @allactcodes - @actcodes
      #@remove = Contract.remove
      #@notconfirmed = User.notconfirmed.collect {|e| e.email}.uniq
      @findit = @contractfour.find(params[:id])
     #@user = User.find_by_actcode_name(:act_code)
    # @user = User.where(actcode_name: @contractfour.id).map {|d|d.email}
     #@user = User.where(actcode_name:)
    else
      redirect_to root_path
    end

  end

  def missingrecords
      @contractfour = Contract.order(params[:sort] || :unique3).tenday.all
      @contractbymonth = @contracts.group_by { |t| t.date_of_event.beginning_of_week}
      @notconfirmed = User.notconfirmed.collect {|e| e.email}.uniq
  end

  # def report
  #  #@contract= Contract.all.collect { |ob| ob.unique3 }.dups
  #  @notconfirmed = User.where(:sign_in_count => 0 ).collect {|e| e.email}
  #     @allactcodes = Contract.all.collect { |obj| obj.act_code }
  #     @actcodes = User.all.collect { |b| b.actcode_name}
  #     @updates = @allactcodes - @actcodes
  #     @upd = @updates.uniq
  #     #@emails = Contract.where('email_address ~= ?','%comcast.net%')
  #     @emails = Contract.emails.collect { |ob| ob.email_address}
  # end

  def report
<<<<<<< HEAD
    @contracts = Contract.unconfirmedevent.tenday.all
    @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
    @userss = @users.collect {|m| m.email}.uniq
=======
   #@contract= Contract.all.collect { |ob| ob.unique3 }.dups
   # @notconfirmed = User.where(:sign_in_count => 0 ).collect {|e| e.email}
   #    @allactcodes = Contract.all.collect { |obj| obj.act_code }
   #    @actcodes = User.all.collect { |b| b.actcode_name}
   #    @updates = @allactcodes - @actcodes
   #    @upd = @updates.uniq
      #@emails = Contract.where('email_address ~= ?','%comcast.net%')
                  #  @emails = Contract.emails.collect { |ob| ob.email_address}
                  #  @prkey = Contract.all.collect { |ab| ab.prntkey23 }
                  # @emaildups = @prkey.dups

                  @contracts = Contract.unconfirmedevent.tenday.all
                   @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
                   @userss = @users.collect {|m| m.email}.uniq
                   #ContractMailer.send_reminder(@userss).deliver

                     @contracts = Contract.unconfirmedevent.tenday.all
                      @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
                      @userss = @users.collect {|m| m.email}.uniq

                     @jackreport = Contract.order(params[:sort]).wedding.jack.theact.threesixfive.all
                     # @additional = Contract.additional(@jackreport)
                      #@prkey = @jackreport.all.collect { |ab| ab.prntkey23 }
                      @pkey = Contract.find_all_by_prntkey23(@jackreport.map {|p|p.prntkey23})
                      @py = @pkey.collect {|g| g.prntkey23}
>>>>>>> newlook
  end

  def confirmjob
    @contract.update_attributes(confirmation: 1)
    flash[:notice] = "Job Confirmed"
    redirect_to @contract
  end

  def emailjobwithnetonly
    ContractMailer.event_info_email_with_net_money(@user,@contract,@additional).deliver
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end

  def emailjobwithallmoney
    ContractMailer.event_info_email_with_all_money(@user,@contract,@additional).deliver
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end

  def emailjobnomoney
    ContractMailer.event_info_email_with_no_money(@user,@contract,@additional).deliver
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end

protected

def find_contract
  @user = current_user
  @contract = Contract.find(params[:id])
  @additional = Contract.additional(@contract)
end

  def themap
    "#{@contract.location_address_line_1}+#{@contract.location_city}+#{@contract.location_state}+#{@contract.location_zip}"
  end

  def gmail
    gmail = Gmail.connect("fresh@sofreshentertainment.com","shaina")
    @mailcount = gmail.inbox.find(:unread) do |email|
      email.read!
    end
    @maillabels = gmail.labels.all
    gmail.logout
  end

end
