# -*- encoding : utf-8 -*-
Wtasystem::Application.routes.draw do
  resources :actnotes, :managements, :contracts, :messages, :actcodes, :incoming_mails,:quotes,:messages,:users
  match "Working/503-error", :to => "working#maintenance_error"

  match "Working/503", :to => "working#maintenance"

  match "Working/500", :to => "working#error"

  match "Working/404", :to => "working#not_found"

  root to: "contracts#index"
  ActiveAdmin.routes(self)
devise_for :users, controllers: {sessions: 'devise/sessions',:confirmations => "confirmations"}, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'cmon_let_me_in' },skip: [:sessions] do
                 get 'signin'  => 'devise/sessions#new', as: :new_user_session
                 post 'signin' => 'devise/sessions#create', as: :user_session
                 get 'signout' => 'devise/sessions#destroy', as: :destroy_user_session
                  #match "register" => "devise/registrations#new", as: :new_user_registration
                   match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation

               end

   match '/confirmjob', to: "contracts#confirmjob"
   match '/emailjobwithnetonly', to: "contracts#emailjobwithnetonly"
   match '/emailjobwithallmoney', to: "contracts#emailjobwithallmoney"
   match '/emailjobnomoney', to: "contracts#emailjobnomoney"
   match '/confirmjob', to: "contracts#confirmjob"
   match '/otheracts', to: "contracts#otheracts"
   match '/import', to: "contracts#import_contracts"
   match '/alljobs', to: "contracts#alljobs"
   match '/missingrecords', to: "contracts#missingrecords"
   match '/mailchimp', to: "contracts#mailchimp"
   match '/calendar', to: "contracts#calendar"
   match '/exportcal', to: "incoming_mails#exportevents"
   match '/gmail', to: "contracts#gmail"
   #match '/users/:id' => "users#edit"
   match 'db/authorize', controller: 'dropbox', action: 'authorize'
   match 'db/upload', controller: 'dropbox', action: 'upload'
   match '/incoming', to: "incoming_mails#create"
   #map.connect ':controller/:action/:id'
   match '/report', to: "contracts#report"

end
