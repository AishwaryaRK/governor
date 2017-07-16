class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'

    create_table :users, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.text :name, :null => false, :default => ''
      tbl.text :email, :null => false, :default => ''

      tbl.text :username, :null => false, :default => ''
      tbl.text :password, :null => false, :default => ''

      tbl.json :features, :default => {}
      tbl.json :metadata, :default => {}

      tbl.bigint :sign_in_count, :default => 0, :null => false

      tbl.datetime :remember_created_at
      tbl.datetime :current_sign_in_at
      tbl.datetime :last_sign_in_at

      tbl.inet :current_sign_in_ip
      tbl.inet :last_sign_in_ip

      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true
    end

    add_index :users, :username, :name => 'users_username_idx', :unique => true
  end
end
