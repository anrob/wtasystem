# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
  set_tab :home
  inherit_resources
  load_and_authorize_resource
  before_filter :everypage
  before_filter :find_contract, :only => [:confirmjob, :emailjobwithnetonly, :emailjobwithallmoney, :emailjobnomoney]
  helper_method :themanager, :themap

  def index
    case @but when "true"
      @contract = Contract.where(act_code: params[:act_code])
      @actcode = Actcode.where(actcode:  params[:act_code]).first
      unless current_user.is? :manager
       @contracts = Contract.mystuff(@user.actcode_name).tenday.all
      else
        @contracts = Contract.where(act_code: @manger.split(",")).tenday.all
      end
      if cannot? :see_others, @contract
        redirect_to root_url
      end
    else

      @contract = Contract.mytoday.mystuff(current_user.actcode_name)
      @actcode = current_user.actcode_name
      @getcompan = Actcode.getallbycompany(current_user)
      @gt = Actcode.find_all_by_management_id(current_user.management_id)
      @cont = Contract.tenday.find_by_act_code(@gt.map {|m| m.actcode})
      @gp = @gt.map {|m| m.actcode}
      @totalnum = @contract.threesixfive.sum(:contract_price)
      unless current_user.is? :manager
      @contracts = Contract.mystuff(current_user.actcode_name).tenday.all
      else
      @contracts = Contract.where(act_code: @manger.split(",")).tenday.all

      end
    end
  end

  def show
    @additional = Contract.additional(@contract)
  end

  def calendar
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    unless current_user.is? :manager
      @contracts = Contract.mystuff(current_user.actcode_name).threesixfive.all
    else
      @contracts = Contract.where(act_code: @manger.split(",")).threesixfive.all
    end
    respond_with contracts: @contracts
  end


  def alljobs
      @contractfour = Contract.order(params[:sort]).tenday.all
      @contracts = Contract.order(params[:sort]).nextsix.all
      @contractbymonth = @contracts.group_by { |t| t.date_of_event.beginning_of_week}
       @allactcodes = Contract.all.collect { |obj| obj.act_code }
        @actcodes = Actcode.all.collect { |b| b.name}
        @updates = @allactcodes - @actcodes
        @remove = Contract.remove

        @notconfirmed = User.notconfirmed.collect {|e| e.email}.uniq
  end

  def report
   #@contract= Contract.all.collect { |ob| ob.unique3 }.dups
   @notconfirmed = User.where(:sign_in_count => 0 ).collect {|e| e.email}
      @allactcodes = Contract.all.collect { |obj| obj.act_code }
      @actcodes = User.all.collect { |b| b.actcode_name}
      @updates = @allactcodes - @actcodes
      @upd = @updates.uniq
      #@emails = Contract.where('email_address ~= ?','%comcast.net%')
      @emails = Contract.emails.collect { |ob| ob.email_address}
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
