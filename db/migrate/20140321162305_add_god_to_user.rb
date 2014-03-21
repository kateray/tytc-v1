class AddGodToUser < ActiveRecord::Migration
  def change
    add_column :users, :god, :boolean
  end
end
