class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth_token = request.env['omniauth.auth']
    @user      = User.find_for_or_create_with_token('social', auth_token)
    if @user.save
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: auth_token.provider.humanize)
      sign_in_and_redirect(@user, :event => :authentication)
    else
      session['devise.google_data'] = auth_token.except(:extra)
      redirect_to(new_user_registration_url, :alert => @user.errors.full_messages.join("\n"))
    end
  end
end
