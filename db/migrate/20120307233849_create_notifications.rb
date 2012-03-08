class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer 	:receiver
      t.integer 	:sender
      t.string 		:type
      t.boolean   :read, :default=>false
      t.timestamps
    end
    add_index :notifications, [:receiver, :sender, :created_at]
  end

  def self.down
    drop_table :notifications
  end
end
