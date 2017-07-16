module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def new
      super
    end

    def create
      super
    end

    def edit
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    def cancel
      super
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username])
    end

    # noinspection RubyInstanceMethodNamingConvention
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username])
    end

    def after_sign_up_path_for(user)
      super(user)
    end

    # noinspection RubyInstanceMethodNamingConvention
    def after_inactive_sign_up_path_for(user)
      super(user)
    end
  end
end
