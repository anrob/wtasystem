# -*- encoding : utf-8 -*-
class ContractsController < ApplicationController
  set_tab :home
  inherit_resources
  load_and_authorize_resource
  before_filter :everypage
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
    #@mana = Actcode.find_by_actcode(current_user.actcode)
      unless current_user.is? :manager
      @contracts = Contract.mystuff(current_user.actcode_name).tenday.all
      else
      @contracts = Contract.where(act_code: @manger.split(",")).tenday.all
     # @totalcount = @contracts.count
      end
    end
      #respond_with contracts: @contract.thisweek
  end

  def show
    #add_breadcrumb "Show Contract", contract_path
    @additional = Contract.additional(@contract)
    # respond_with do |format|
    #     format.html
    #     format.pdf do
    #       pdf = ContractPdf.new(@contract, view_context)
    #       send_data pdf.render, filename: "contract_#{@contract.contract_number}.pdf",
    #
    #       type: "application/pdf",
    #       disposition: "inline"
    #     end
    #end

  end

  def calendar
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
   # @mana = Actcode.find_by_actcode(current_user.actcode)
    #case @but when "true"
    unless current_user.is? :manager
      @contracts = Contract.mystuff(current_user.actcode_name).threesixfive.all
    else
      @contracts = Contract.where(act_code: @manger.split(",")).threesixfive.all
    end
    respond_with contracts: @contracts
  end


  def alljobs
      @contracts = Contract.order(params[:sort]).tenday.all
      @contractbymonth = @contracts.group_by { |t| t.date_of_event.beginning_of_week}
      #@last = Contract.last(1).reverse.map {|m| m.created_at}.flatten!
      #@cool =  Chronic.parse(@last, "24 hours ago")
       @allactcodes = Contract.all.collect { |obj| obj.act_code }.dups
        @actcodes = Actcode.all.collect { |b| b.name}
        @updates = @allactcodes - @actcodes
        @remove = Contract.remove

        @notconfirmed = User.notconfirmed.collect {|e| e.email}.uniq
  end

  def report
         @allactcodes = Contract.all.collect { |obj| obj.act_code }
          @actcodes = Actcode.all.collect { |b| b.name}
          @updates = @allactcodes - @actcodes
     # @contracts = Contract.unconfirmedevent.tenday.all
     #    @actcodes = Actcode.find_all_by_actcode(@contracts.map {|m|m.act_code})
     #
     #    @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
     #    @u = @theusers.collect {|m| m.email}.uniq
     #    @contract = Contract.mystuff("FROB").unconfirmedevent.tenday.all
     #    ContractMailer.send_user_reminder(@u).deliver
  end

  def confirmjob
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    #ContractMailer.event_info_email(@user,@contract,@additional).deliver
    @contract.update_attributes(confirmation: 1)
    flash[:notice] = "Job Confirmed"
    redirect_to :back
  end

  def emailjobwithnetonly
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    ContractMailer.event_info_email_with_net_money(@user,@contract,@additional).deliver
    #@contract.update_attributes(confirmation: 1)
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end

  def emailjobwithallmoney
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    ContractMailer.event_info_email_with_all_money(@user,@contract,@additional).deliver
    #@contract.update_attributes(confirmation: 1)
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end

  def emailjobnomoney
    @user = current_user
    @contract = Contract.find(params[:id])
    @additional = Contract.additional(@contract)
    ContractMailer.event_info_email_with_no_money(@user,@contract,@additional).deliver
    #@contract.update_attributes(confirmation: 1)
    flash[:notice] = "Info Mailed"
    redirect_to :back
  end


#   def exportevents
#     require 'icalendar'
#  #@event = Contract.mystuff(current_user.actcode_name).tenday.all
#  @event = Contract.find_by_id("45,031")
#  # @event
#   @calendar = Icalendar::Calendar.new
#      event = Icalendar::Event.new
#     # event.start = @event.event_start_time.strftime("%Y%m%dT%H%M%S")
#   #   event.end = @event.dt_time.strftime("%Y%m%dT%H%M%S")
#   #   event.summary = @event.summary
#   #   event.description = @event.description
#   #   event.location = @event.location
#
#   event.summary     = "Mercury MA-6"
#      event.description = "First US Manned Spaceflight\n(NASA Code: Mercury 13/Friendship 7)"
#      event.dtstart     = Time.parse("2012-07-20T09:47:39-0500").getutc
#      event.dtend       = Time.parse("2012-07-20T14:43:02-0500").getutc
#      event.location    = "Cape Canaveral"
#      event.add_attendee  "john.glenn@nasa.gov"
#      event.url         = "http://nasa.gov"
#  @calendar.add event
#
#
#      @calendar.publish
#
# headers['Content-Type'] = "text/calendar; charset=UTF-8"
# render layout: false, :text => @calendar.to_ical
#
# end

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
