Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :skip => [:registrations]

  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end

  mount HealthMonitor::Engine, at: '/_'

  root to: 'home#index'


  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end

  get '_ping', :controller => :ping, :action => :index

  get '/saml/auth' => 'saml_idp#new'
  get '/saml/metadata' => 'saml_idp#show'
  post '/saml/auth' => 'saml_idp#create'
  match '/saml/logout' => 'saml_idp#logout', via: [:get, :post, :delete]
end
