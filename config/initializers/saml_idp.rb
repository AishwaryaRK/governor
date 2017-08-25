SamlIdp.configure do |config|
  # noinspection RubyUnusedLocalVariable
  base = Governor::Config[:app, :saml_idp, :sp_base]

  service_providers = {
      "#{Governor::Config[:app, :saml_idp, :sp_base]}/saml" => {
          :fingerprint  => Governor::Config[:app, :saml_idp, :sp_fingerprint],
          :metadata_url => "#{Governor::Config[:app, :saml_idp, :sp_base]}/saml/metadata"
      },
  }

  config.organization_name            = 'Governor'
  config.organization_url             = Governor::Config[:app, :saml_idp, :sp_base]
  config.base_saml_location           = "#{base}/saml"
  config.single_service_post_location = "#{base}/saml/auth"
  config.session_expiry               = 3600

  config.name_id.formats = {
      transient:     -> (principal) {"#{principal.username}@governor.example.com"},
      persistent:    -> (principal) {"#{principal.username}@governor.example.com"},
      email_address: -> (principal) {"#{principal.username}@governor.example.com"}
  }

  config.attributes = {
      'eduPersonPrincipalName' => {
          'name'        => 'urn:oid:1.3.6.1.4.1.5923.1.1.1.6',
          'name_format' => 'urn:oasis:names:tc:SAML:2.0:attrname-format:uri',
          'getter'      => ->(principal) {
            "#{principal.username}@go-jek.com"
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

  config.service_provider.persisted_metadata_getter = ->(identifier, service_provider) {
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
