class CreateAccountsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.belongs_to :user,
                     :index => {:name   => 'accounts_users_id_unq_idx',
                                :unique => true}

      tbl.text :uid, :null => false, :default => ''
      tbl.text :provider, :null => false, :default => ''

      tbl.text :type, :null => false, :default => ''

      tbl.json :token, :default => {}
      tbl.json :features, :default => {}
      tbl.json :metadata, :default => {}

      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true
    end

    add_foreign_key :accounts, :users, :name => 'accounts_user_id_fk'

    add_index :accounts, :uid, :name => 'accounts_uid_unq_idx', :unique => true
    add_index :accounts, :provider, :name => 'accounts_provider_idx'
  end
end
