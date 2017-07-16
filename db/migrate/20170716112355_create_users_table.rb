class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |tbl|
      tbl.string :username, :null => false, :default => ''
      tbl.string :email, :null => false, :default => ''
      tbl.string :encrypted_password, :null => false, :default => ''

      tbl.string :reset_password_token
      tbl.datetime :reset_password_sent_at

      tbl.datetime :remember_created_at
      tbl.integer :sign_in_count, :default => 0, :null => false

      tbl.datetime :current_sign_in_at
      tbl.datetime :last_sign_in_at
      tbl.inet :current_sign_in_ip
      tbl.inet :last_sign_in_ip

      tbl.integer :failed_attempts, :default => 0, :null => false
      tbl.string :unlock_token
      tbl.datetime :locked_at

      tbl.timestamps :null => false
    end

    add_index :users, :email, :unique => true
    add_index :users, :username, :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :unlock_token, :unique => true
  end
end
