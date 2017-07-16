module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def new
      super
    end

    def create
      super
    end

    def show
      super
    end

    protected

    # noinspection RubyInstanceMethodNamingConvention
    def after_resending_confirmation_instructions_path_for(username)
      super(username)
    end

    def after_confirmation_path_for(username, user)
      super(username, user)
    end
  end

end
