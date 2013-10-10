class ReportsController < ApplicationController

  def index
      @email = Contract.emails.map { |ob|ob.email_address}
      @emaillist = @email.map { |e| e.gsub(/;.*/, '') }
      @emaillistd = @emaillist.map { |p| p.gsub(/,.*/, "")}
      #@emaillist = @emaillists.map { |e| e.gsub(/;.*/, ';') }

            @contracts = Contract.unconfirmedevent.tenday.all
              @users = User.find_all_by_actcode_name(@contracts.map {|m|m.act_code})
              @userss = @users.collect {|m| m.email}.uniq

              @contracts = Contract.unconfirmedevent.tenday.all
              @actcodes = Actcode.find_all_by_actcode(@contracts.map {|m|m.act_code})
              @theusers = User.with_role("manager").find_all_by_management_id(@actcodes.map {|m| m.management_id})
              @u = @theusers.collect {|m| m.email}.uniq

              @jackreport = Contract.wedding.jack.theact
  end

  def time
      @report = TimeReport.render_html(:user => current_user)
     end
end
