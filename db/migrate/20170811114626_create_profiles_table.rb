class CreateProfilesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles, :id => :bigserial do |tbl|
      tbl.uuid :uuid, :default => 'uuid_generate_v4()'

      tbl.belongs_to :user,
                     :index => {:name   => 'profiles_users_id_unq_idx',
                                :unique => true}

      tbl.text :display_name, :null => false, :default => ''
      tbl.text :public_email, :null => false, :default => ''
      tbl.text :avatar_url, :null => false, :default => ''
      tbl.text :website, :null => false, :default => ''
      tbl.text :company, :null => false, :default => ''
      tbl.text :location, :null => false, :default => ''
      tbl.text :biography, :null => false, :default => ''

      tbl.json :features, :default => {}
      tbl.json :metadata, :default => {}

      tbl.datetime :created_at, :null => false
      tbl.datetime :updated_at, :null => false
      tbl.datetime :deleted_at, :null => true
    end

    add_foreign_key :accounts, :users, :name => 'profiles_user_id_fk'
  end
end
