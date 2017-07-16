Rails.application.routes.draw do
  devise_for :users, :controllers => {
      :sessions           => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  mount HealthMonitor::Engine, at: '/_'

  root to: 'home#index'

  get '_ping', :controller => :ping, :action => :index
end
