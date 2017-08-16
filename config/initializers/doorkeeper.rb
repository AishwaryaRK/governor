Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    User.find_by_id(session[:user_id]) || redirect_to(new_user_session_url)
  end
end
