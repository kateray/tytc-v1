class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :user_id
      t.integer :votes_count, :default => 0
      t.integer :comments_count, :default => 0
      t.string :url
      t.text :description
      t.string :title
      t.timestamps
    end
  end
end
