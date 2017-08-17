class SamlIdpController < SamlIdp::IdpController
  private

  def idp_authenticate(email, _password)
    User.by_email(email).first
  end

  def idp_make_saml_response(found_user)
    encode_response found_user, encryption: {
        cert:             saml_request.service_provider.cert,
        block_encryption: 'aes256-cbc',
        key_transport:    'rsa-oaep-mgf1p'
    }
  end

  def idp_logout
    user = User.by_email(saml_request.name_id)
    user.logout
  end
end
