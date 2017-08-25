class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  NotAuthorized = Class.new(ActionController::RoutingError)

  rescue_from ApplicationController::NotAuthorized do
    render :file => 'public/403.html', :layout => false, :status => 403
  end
end
