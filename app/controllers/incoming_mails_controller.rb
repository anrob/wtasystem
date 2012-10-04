class IncomingMailsController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  class AttachmentFile < Tempfile
      attr_accessor :content_type
  end

  include ActiveModel::Dirty

  def create
   require 'base64'
   require 'csv'
     @message = Mail.new(params[:message])
       attachment = @message.attachments.first
       atdecode = attachment.decoded
       CSV.parse(atdecode,{headers: true, col_sep:  "|", force_quotes:  true, quote_char: "~", converters: :date}) do |row|
                                       @contracts = Contract.unscoped.where(:unique3 => row[0]).first_or_create
                                       @contracts.update_attributes( {
                                        unique3: row[0],
                                        prntkey23: row[1],
                                        prntkey13: row[2],
                                        act_code: row[3],
                                        accounting_confirmation_date: row[4],
                                        act_form: row[5],
                                        act_net: row[6],
                                        agent: row[7],
                                        act_booked: row[8],
                                        credit_card_fee: row[9],
                                        ceremonoy_location_name: row[10],
                                        ceremonoy_address_line_1: row[11],
                                        ceremony_address_line_2: row[12],
                                        ceremony_location_city: row[13],
                                        ceremony_instrumenttation: row[14],
                                        seremonly_location_state: row[15],
                                        ceremony_location_zip: row[16],
                                        ceremony_start_time: row[17],
                                        ceremony_charge: row[18],
                                        cocktails_charge: row[19],
                                        early_setup_charge: row[20],
                                        early_setup_time: row[21],
                                        contract_price: row[22],
                                        charge_per_horn: row[23],
                                        other_charges: row[24],
                                        cocktail_instrumentation: row[25],
                                        cocktail_time: row[26],
                                        confirmation_date: row[27],
                                        contract_sent_date: row[28],
                                        contract_number: row[29],
                                        contract_revision_number: row[30],
                                        date_of_cancellation: row[31],
                                        date_of_ceremony: row[32],
                                        charge_per_dancer: row[33],
                                        number_of_dancers: row[34],
                                        giveaways: row[35],
                                        giveaways_charge: row[36],
                                        dj_tech_charge: row[37],
                                        tech: row[38],
                                        event_end_time: row[39],
                                        number_of_horns: row[40],
                                        type_of_light_show: row[41],
                                        location_name: row[42].inspect,
                                        location_address_line_1: row[43],
                                        location_address_line_2: row[44],
                                        location_city: row[45],
                                        location_state: row[46],
                                        location_zip: row[47],
                                        location_phone: row[48],
                                        non_commissionable_charges: row[49],
                                        pick_up_amount: row[50],
                                        explanation_opf_pickup_adjustment: row[51],
                                        capital_music_player: row[52],
                                        capital_music_pay: row[53],
                                        base_price_of_act: row[54],
                                        questionnaire_received_date: row[55],
                                        questionnaire_sent_date: row[56],
                                        referral_fee_amount: row[57],
                                        referral_fee_to: row[58],
                                        song_requests: row[59],
                                        event_start_time: row[60],
                                        contract_status: row[61],
                                        tax_amount: row[62],
                                        type_of_act: row[63],
                                        type_of_event: row[64],
                                        videographer_1: row[65],
                                        videographer_2: row[66],
                                        videgrapher_3: row[67],
                                        date_of_event: Date.strptime(row[68], "%m/%d/%Y").to_s(:db),
                                        first_name: row[69],
                                        last_name: row[70],
                                        email_address: row[71],
                                        company: row[72],
                                        brides_names: row[73],
                                        grooms_name: row[74],
                                        home_phone: row[75],
                                        work_phone: row[76],
                                        cell_phone: row[77],
                                        party_planner: row[78],
                                        act_notes: row[79].inspect,
                                        contract_provisions: row[80].inspect,
                                        reception_location: row[81],
                                        confirmation: 0 })

                             end

     render layout: false
end




 def exportevents
    require 'icalendar'
 @event = Contract.mystuff(current_user.actcode_name).threesixfive.all
  #@event = Contract.find_by_id("45,031")
  @calendar = Icalendar::Calendar.new
   @event.each do |d|
     event = Icalendar::Event.new

    # event.start = @event.event_start_time.strftime("%Y%m%dT%H%M%S")
  #   event.end = @event.dt_time.strftime("%Y%m%dT%H%M%S")
  #   event.summary = @event.summary
  #   event.description = @event.description
  #   event.location = @event.location
     event.summary     = d.last_name
     event.description = d.act_booked
     event.start     = d.date_of_event.strftime("%Y%m%d")
     event.end       = d.date_of_event.strftime("%Y%m%d")
     event.location    = d.location_name
 @calendar.add event

     @calendar.publish
       end

headers['Content-Type'] = "text/calendar; charset=UTF-8"
render layout: false, :text => @calendar.to_ical

end
end