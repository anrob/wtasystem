# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Actcode.delete_all
# ActiveRecord::Base.connection.reset_pk_sequence!('Actcode')
# open("db/actcodes.csv") do |countries|
#  countries.read.each_line do |country|
#    actcode,name,management_id = country.chomp.split("|")
#    Actcode.create!(
#    actcode: actcode,
#    description: name,
#    management_id: management_id
#    )
#
#User.delete_all
password_length = 6

#ALTER SEQUENCE users_id_seq RESTART WITH 1
   open("db/WTAUSERS.csv") do |user|

     user.read.each_line do |users|
        password = Devise.friendly_token.first(password_length)
      actcode_name,management_id,first_name,last_name,email,phone = users.chomp.split("|")
      muser = User.create!(
      email: email,
      password: password,
      password_confirmation: password,
      management_id: management_id,
      first_name: first_name,
      last_name: last_name,
      phone_number: phone,
      actcode_name: actcode_name,
      )
      #User.all.send_confirmation_instructions
      #RegistrationMailer.welcome(user, password).deliver
   # unique3,prntkey23,prntkey13,actcode,acctcnfdat,actform,actnet,agtfulnam,bookedact,ccfee,cerloc,cerloc13,ceradd23,cercity3,cerinst,cerst3,cerzip3,cersttm3,chgcer,chgcoc,chgeset,esettime,chggrs,chghorn,chgothr,cocinst,confdate,consenddat,contractno,contrevnum,datecancl,datecer,djdanchg,djdancnum,djgiveaway,djgivechg,djtechchg,djtechyn,endtime3,hornnum,lightshow,location3,locadd13,locadd23,loccity3,locstate3,loczip3,phnloc3,noncomchg,pickupamnt,pickupexpl,player,playerspay,priceact,quesrecdat,questsent,refamnt,refpay,songreqst,starttm3,status3,tax,typeact3,typeevnt3,videog1,videog2,videog3,dateev,firstname,lastname,numofpages,orgname,name1,name2,phnhme3,phnwrk3,phncell3 = country.chomp.split("|")
   #  Contract.create!(
   #  unique3: unique3,
   #  prntkey23: prntkey23,
   #  prntkey13: prntkey13,
   #  act_code: actcode,
   #  accounting_confirmation_date: acctcnfdat,
   #  act_form: actform,
   #  act_net: actnet,
   #  agent: agtfulnam,
   #  act_booked: bookedact,
   #  credit_card_fee: ccfee,
   #  ceremony_address_line_2: ceradd23,
   #  ceremony_location_city: cercity3,
   #  ceremony_instrumenttation: cerinst,
   #  ceremonoy_location_name: cerloc,
   #  seremonly_location_state: cerst3,
   #  ceremony_start_time: cersttm3,
   #  ceremony_location_zip: cerzip3,
   #  ceremony_charge: chgcer,
   #  cocktails_charge: chgcoc,
   #  early_setup_charge: chgeset,
   #  contract_price: chggrs,
   #  charge_per_horn: chghorn,
   #  other_charges: chgothr,
   #  cocktail_instrumentation: cocinst,
   #  confirmation_date: confdate,
   #  contract_sent_date: consenddat,
   #  contract_number: contractno,
   #  contract_revision_number: contrevnum,
   #  date_of_cancellation: datecancl,
   #  date_of_ceremony: datecer,
   #  charge_per_dancer: djdanchg,
   #  number_of_dancers: djdancnum,
   #  giveaways: djgiveaway,
   #  giveaways_charge: djgivechg,
   #  dj_tech_charge: djtechchg,
   #  tech: djtechyn,
   #  event_end_time: endtime3,
   #  early_setup_time: esettime,
   #  number_of_horns: hornnum,
   #  type_of_light_show: lightshow,
   #  location_address_line_1: locadd13,
   #  location_address_line_2: locadd23,
   #  location_name: location3,
   #  location_city: loccity3,
   #  location_state: locstate3,
   #  location_zip: loczip3,
   #  non_commissionable_charges: noncomchg,
   #  location_phone: phnloc3,
   #  pick_up_amount: pickupamnt,
   #  explanation_opf_pickup_adjustment: pickupexpl,
   #  capital_music_player: player,
   #  capital_music_pay: playerspay,
   #  base_price_of_act: priceact,
   #  questionnaire_received_date: quesrecdat,
   #  questionnaire_sent_date: questsent,
   #  referral_fee_amount: refamnt,
   #  referral_fee_to: refpay,
   #  song_requests: songreqst,
   #  event_start_time: starttm3,
   #  contract_status: status3,
   #  tax_amount: tax,
   #  type_of_act: typeact3,
   #  type_of_event: typeevnt3,
   #  videographer_1: videog1,
   #  videographer_2: videog2,
   #  videgrapher_3: videog3,
   #  date_of_event: dateev,
   #  first_name: firstname,
   #  last_name: lastname,
   #  email_address: numofpages,
   #  company: orgname,
   #  brides_names: name1,
   #  grooms_name: name2,
   #  home_phone: phnhme3,
   #  work_phone: phnwrk3,
   #  cell_phone: phncell3 )
    #party_planner: partyplann
    #act_notes: actnotes,

    #dateev,firstname,lastname,numofpages,orgname,name1,name2,phnhme3,phnwrk3,phncell3
    #contract_provisions: contprov )
  end
  end
