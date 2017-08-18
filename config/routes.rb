Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  devise_scope :user do
    get '/login', :to => 'devise/cas_sessions#new'
    post '/login', :to => 'devise/cas_sessions#create'
    delete '/logout', :to => 'devise/cas_sessions#destroy'

    get '/saml/init', :to => 'saml#init'
    post '/saml/consume', :to => 'saml#consume'

    get '/saml/auth', :to => 'saml_idp#new'
    post '/saml/auth', :to => 'saml_idp#create'
    get '/saml/metadata', :to => 'saml_idp#show'
  end

  mount HealthMonitor::Engine, :at => '/_'

  root :to => 'home#index'

  get '_ping', :controller => :ping, :action => :index
end
