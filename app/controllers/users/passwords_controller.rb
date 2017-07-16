class Users::PasswordsController < Devise::PasswordsController
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

  protected

  # noinspection RubyInstanceMethodNamingConvention
  def after_resetting_password_path_for(user)
    super(user)
  end

  # noinspection RubyInstanceMethodNamingConvention
  def after_sending_reset_password_instructions_path_for(username)
    super(username)
  end
end
