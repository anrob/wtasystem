# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
  set_tab :home
  inherit_resources
  load_and_authorize_resource
  before_filter :everypage  
  #before_filter :update_password
  helper_method :themanager, :themap


  def index 
   
    case @but when "true"
      @contract = Contract.where(:act_code => params[:act_code])
      @actcode = Actcode.where(:actcode => params[:act_code]).first

      @mana = Actcode.find_by_actcode(current_user.actcode_name)
      unless current_user.is? :manager
       @contracts = Contract.mystuff(@user.actcode_name).contractstatsus.tenday.all  
      else
        @contracts = Contract.where(:act_code => @manger.split(",")).contractstatsus.tenday.all
      end
      if cannot? :see_others, @contract
        redirect_to root_url
      end
    else
      #@mana = Actcode.find_by_id(current_user.actcode_id)
      @contract = Contract.mytoday.mystuff(current_user.actcode_name)
      @actcode = current_user.actcode_name
      @getcompan = Actcode.getallbycompany(current_user)
      @gt = Actcode.find_all_by_management_id(current_user.management_id)#.collect {|m| m.actcode} 
      @cont = Contract.contractstatsus.tenday.find_by_act_code(@gt.map {|m| m.actcode})
      # @unconfirmed = Contract.includes("actcodes").where(:act_code => params[:act_code]).count
      @gp = @gt.map {|m| m.actcode}
      @totalnum = @contract.threesixfive.sum(:contract_price)
    @mana = Actcode.find_by_actcode(current_user.actcode)
      unless current_user.is? :manager
        @contracts = Contract.mystuff(@user.actcode).contractstatsus.tenday.all  
      else
        @contracts = Contract.where(:act_code => @manger.split(",")).tenday.contractstatsus.all
        @totalcount = @contracts.count
       # @unconfirmed = @contracts.count('act_code = ?')
      end
    end 
    respond_with :contracts => @contract.thisweek
  end

  def show
    add_breadcrumb "Show Contract", contract_path
    @additional = Contract.contractstatsus.additional(@contract)
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
    @mana = Actcode.find_by_actcode(current_user.actcode)
    #case @but when "true"
    unless current_user.is? :manager
      @contracts = Contract.contractstatsus.mystuff(@user.actcode_name).threesixfive.all  
    else
      @contracts = Contract.contractstatsus.where(:act_code => @manger.split(",")).threesixfive.all
    end
    respond_with :contracts => @contracts
  end
  def alljobs

    @mana = Actcode.find_by_actcode(current_user.actcode_name)
   unless current_user.is? :manager
      @contracts = Contract.mystuff(@user.actcode.actcode).contractstatsus.tenday.all
      #@contracts = Contract.contractstatsus.unconfirmedevent.innextten
    else

      @noactcode = Contract.justimported
      @contracts = Contract.contractstatsus.unconfirmedevent.innextten
      @actcodes = Actcode.find_all_by_actcode(@contracts.map {|m| m.act_code})
      #@users = User.find_all_by_actcode_name(@actcodes.id) 
      @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
      @recipients = @theusers.collect {|m| m.email}
    end
  end

  def confirmjob
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    ContractMailer.event_info_email(@user,@contract,@additional).deliver
    @contract.update_attributes(:confirmation => 1)
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
