class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :link_id
      t.text :content
      t.timestamps
    end
  end
end
