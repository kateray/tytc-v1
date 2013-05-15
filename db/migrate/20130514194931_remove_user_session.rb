class RemoveUserSession < ActiveRecord::Migration
  def up
    drop_table :user_sessions
  end

  def down
    create_table :user_sessions do |t|
      t.timestamps
    end
  end
end
