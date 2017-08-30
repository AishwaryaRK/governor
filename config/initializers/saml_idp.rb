SamlIdp.configure do |config|
  # noinspection RubyUnusedLocalVariable
  base   = Governor::Config[:app, :saml_idp, :sp_base]
  domain = Governor::Config[:app, :saml_idp, :sp_domain]

  config.x509_certificate = <<-CERT
-----BEGIN CERTIFICATE-----
#{Governor::Config[:app, :saml_idp, :x509_certificate]}
-----END CERTIFICATE-----
  CERT

  config.secret_key = <<-CERT
-----BEGIN RSA PRIVATE KEY-----
#{Governor::Config[:app, :saml_idp, :secret_key]}
-----END RSA PRIVATE KEY-----
  CERT

  service_providers = {
      Governor::Config[:app, :saml_idp, :sp_data_dog_sso_url]  => {
          :fingerprint  => Governor::Config[:app, :saml_idp, :sp_fingerprint],
          :metadata_url => Governor::Config[:app, :saml_idp, :sp_data_dog_metadata_url]
      },
      Governor::Config[:app, :saml_idp, :sp_new_relic_sso_url] => {
          :fingerprint  => Governor::Config[:app, :saml_idp, :sp_fingerprint],
          :metadata_url => Governor::Config[:app, :saml_idp, :sp_new_relic_metadata_url]
      },
      Governor::Config[:app, :saml_idp, :sp_mixpanel_sso_url]  => {
          :fingerprint  => Governor::Config[:app, :saml_idp, :sp_fingerprint],
          :metadata_url => Governor::Config[:app, :saml_idp, :sp_mixpanel_metadata_url]
      }
  }

  config.organization_name = Governor::Config[:app, :saml_idp, :organization_name]
  config.organization_url  = Governor::Config[:app, :saml_idp, :organization_url]

  config.base_saml_location           = Governor::Config[:app, :saml_idp, :base_saml_location]
  config.single_service_post_location = Governor::Config[:app, :saml_idp, :single_service_post_location]
  config.session_expiry               = Governor::Config[:app, :saml_idp, :session_expiry].to_i

  config.name_id.formats = {
      transient:     -> (principal) {"#{principal.username}@#{domain}"},
      persistent:    -> (principal) {"#{principal.username}@#{domain}"},
      email_address: -> (principal) {"#{principal.username}@#{domain}"}
  }

  config.attributes = {
      'eduPersonPrincipalName' => {
          'name'        => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
          'name_format' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
          'getter'      => ->(principal) {
            "#{principal.username}@#{domain}"
          }
      },
      'sn'                     => {
          'name'        => 'urn:oid:2.5.4.4',
          'name_format' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
          'getter'      => ->(principal) {
            principal.username
          }
      },
      'givenName'              => {
          'name'        => 'urn:oid:2.5.4.42',
          'name_format' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
          'getter'      => ->(principal) {
            principal.username
          }
      }
  }

  config.service_provider.metadata_persister = ->(identifier, settings) {
    fname = identifier.to_s.gsub(/\/|:/, '_')
    `mkdir -p #{Rails.root.join('cache/saml/metadata')}`
    File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
      Marshal.dump settings.to_h, f
    end
  }

  config.service_provider.persisted_metadata_getter = ->(identifier, _service_provider) {
    fname = identifier.to_s.gsub(/\/|:/, '_')
    `mkdir -p #{Rails.root.join('cache/saml/metadata')}`
    full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
    if File.file?(full_filename)
      File.open full_filename, 'rb' do |f|
        Marshal.load f
      end
    end
  }

  config.service_provider.finder = ->(issuer_or_entity_id) do
    service_providers[issuer_or_entity_id]
  end
end
