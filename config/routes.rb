Rails.application.routes.draw do
  devise_for :users, :controllers => {
      :sessions => 'users/sessions'
  }

  mount HealthMonitor::Engine, at: '/_'

  root to: 'home#index'

  get '_ping', :controller => :ping, :action => :index
end