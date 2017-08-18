class SamlController < ApplicationController
  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response          = OneLogin::RubySaml::Response.new(params[:SAMLResponse],
                                                         :skip_recipient_check => true)
    response.settings = saml_settings
    if response.name_id
      authorize_success({:message => "w00t! #{response.name_id}"})
    else
      authorize_failure(response.errors)
    end
  end

  private

  def saml_settings
    settings                                = OneLogin::RubySaml::Settings.new
    settings.assertion_consumer_service_url = "#{Governor::Config[:app, :saml_idp, :sp_base]}/saml/consume"
    settings.issuer                         = "#{Governor::Config[:app, :saml_idp, :sp_base]}/saml/metadata"
    settings.idp_sso_target_url             = "#{Governor::Config[:app, :saml_idp, :sp_base]}/saml/auth"
    settings.idp_cert_fingerprint           = Governor::Config[:app, :saml, :sp_fingerprint]
    settings.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'
    settings.authn_context                  = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
    settings.attributes_index               = 5
    settings.attribute_consuming_service.configure do
      service_name 'Service'
      service_index 5
      add_attribute :name          => 'Name',
                    :name_format   => 'Name Format',
                    :friendly_name => 'Friendly Name'
    end
    settings
  end

  def authorize_success(message = {:message => 'w00t!'})
    render :json => message, :status => :ok
  end

  def authorize_failure(error = {:error => 'HTTP 403 Forbidden'})
    render :json => error, :status => :forbidden
  end
end
