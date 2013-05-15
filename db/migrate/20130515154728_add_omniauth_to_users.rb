class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, default: 'github'
    add_column :users, :uid, :string
  end
end
