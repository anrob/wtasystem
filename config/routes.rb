# -*- encoding : utf-8 -*-
Wtasystem::Application.routes.draw do
resources :actnotes, :managements, :contracts, :messages, :actcodes
devise_for :users, :controllers => {:sessions => 'devise/sessions'}, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }, :skip => [:sessions] do
                 get 'signin' => 'devise/sessions#new', :as => :new_user_session
                 post 'signin' => 'devise/sessions#create', :as => :user_session
                 get 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
                  match "register" => "devise/registrations#new", :as => :new_user_registration
                   #get 'users', :to => 'users#show', :as => :user_root
               end
resources :users
   root :to => "contracts#index"
   match '/confirmjob', :to => "contracts#confirmjob"
   match '/otheracts', :to => "contracts#otheracts"
   match '/import', :to => "contracts#import_contracts"
   match '/alljobs', :to => "contracts#alljobs"
   match '/mailchimp', :to => "contracts#mailchimp"
   match '/calendar', :to => "contracts#calendar"
   match '/gmail', :to => "contracts#gmail"
   #match '/otheracts/*actcode', :to => "contracts#otheracts"
   match '/users/:id'  => "users#edit"
   match 'db/authorize', :controller => 'dropbox', :action => 'authorize'
   match 'db/upload', :controller => 'dropbox', :action => 'upload'
   #match '/incoming', :to => "incoming_mails#create"
end
