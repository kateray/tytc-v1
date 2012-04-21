class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :group
      t.integer :links_count, :default => 0
      t.integer :user_id
      t.timestamps
    end
  end
end
