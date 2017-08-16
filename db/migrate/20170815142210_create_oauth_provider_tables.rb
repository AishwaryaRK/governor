class CreateOauthProviderTables < ActiveRecord::Migration[5.1]
  def change
    create_table :oauth_applications, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.text :uid, :null => false
      tbl.text :name, :null => false
      tbl.text :secret, :null => false
      tbl.text :redirect_uri, :null => false
      tbl.text :scopes, :null => false, default: ''

      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true
    end

    add_index :oauth_applications, :uid, :name => 'oauth_applications_uid_idx', :unique => true

    create_table :oauth_access_grants, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.bigint :resource_owner_id, :null => false
      tbl.references :application, :null => false
      tbl.bigint :expires_in, :null => false
      tbl.text :redirect_uri, :null => false
      tbl.text :token, :null => false
      tbl.text :scopes

      tbl.datetime :revoked_at, :null => true
      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true

    end

    add_index :oauth_access_grants, :token, :name => 'oauth_access_grants_token_idx', :unique => true

    add_foreign_key :oauth_access_grants,
                    :oauth_applications,
                    :name   => 'oauth_access_grants_application_id_fk',
                    :column => :application_id


    create_table :oauth_access_tokens, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.bigint :resource_owner_id
      tbl.references :application

      tbl.text :token, :null => false
      tbl.text :refresh_token
      tbl.bigint :expires_in
      tbl.bigint :previous_refresh_token, :null => false, :default => ''
      tbl.text :scopes

      tbl.datetime :revoked_at, :null => true
      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true
    end

    add_index :oauth_access_tokens, :token, :name => 'oauth_access_tokens_token_idx', :unique => true
    add_index :oauth_access_tokens, :resource_owner_id, :name => 'oauth_access_tokens_resource_owner_id_idx'
    add_index :oauth_access_tokens, :refresh_token, :name => 'oauth_access_tokens_refresh_token_idx', :unique => true

    add_foreign_key :oauth_access_tokens,
                    :oauth_applications,
                    :name   => 'oauth_access_tokens_application_id_fk',
                    :column => :application_id
  end
end
