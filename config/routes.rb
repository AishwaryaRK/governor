Rails.application.routes.draw do
  mount HealthMonitor::Engine, at: '/_'
  get '_ping', :controller => :ping, :action => :index
end
