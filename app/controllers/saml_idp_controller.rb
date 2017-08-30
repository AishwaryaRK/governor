class SamlIdpController < ApplicationController
  include SamlIdp::Controller

  before_action :validate_saml_request, :only => [:new, :create]

  protect_from_forgery :except => [:new, :create]

  def new
    @saml_request = params[:SAMLRequest]
    @relay_state  = params[:RelayState]
    render 'saml_idp/new', :layout => 'auto_submit_form'
  end

  def show
    render :xml => SamlIdp.metadata.signed
  end

  def create
    if idp_authenticate
      @saml_response = idp_make_saml_response
      @relay_state   = params[:RelayState]
      render 'saml_idp/create', :layout => 'auto_submit_form'
    end
  end

  def destroy
    idp_logout
    @saml_response = idp_make_saml_response
    @relay_state   = params[:RelayState]
    render 'saml_idp/destroy', :layout => 'auto_submit_form'
  end

  private

  def validate_saml_request(raw_saml_request = params[:SAMLRequest])
    decode_request(raw_saml_request)
    raise ApplicationController::NotAuthorized.new(:unauthorized) unless valid_saml_request?
  end

  def idp_authenticate
    current_user
  end

  def idp_make_saml_response
    encode_response(current_user, :expiry => (50 * 60))
  end

  def idp_logout
    current_user.logout
  end
end
