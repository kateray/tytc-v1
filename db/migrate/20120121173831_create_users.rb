class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.text :description
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token
      t.string   :perishable_token
      t.integer  :login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.string   :current_login_ip
      t.integer :github_id
      t.string :github_email
      t.string :github_username
      t.timestamps
    end
  end
end
