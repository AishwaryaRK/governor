class SamlIdpController < ApplicationController
  include SamlIdp::Controller

  before_action :validate_saml_request, :only => [:new, :create]

  def new
    render 'saml_idp/new'
  end

  def show
    render :xml => SamlIdp.metadata.signed
  end

  def create
    if idp_authenticate
      @saml_response = idp_make_saml_response
      render 'saml_idp/saml_post'
    else
      @saml_idp_fail_msg = 'Incorrect email or password.'
      render 'saml_idp/new'
    end
  end

  def logout
    idp_logout
    @saml_response = idp_make_saml_response
    render 'saml_idp/saml_post'
  end

  private

  def idp_authenticate
    current_user
  end

  def idp_make_saml_response
    encode_response current_user
  end

  def idp_logout
    current_user.logout
  end
end
