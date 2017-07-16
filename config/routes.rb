Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :controllers => {
      :registrations      => 'users/registrations',
      :password           => 'users/passwords',
      :sessions           => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  mount HealthMonitor::Engine, at: '/_'

  root to: 'home#index'


  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end

  get '_ping', :controller => :ping, :action => :index
end
