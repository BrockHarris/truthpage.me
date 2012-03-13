class CreateNotifications < ActiveRecord::Migration
    def self.up
      create_table :notifications do |t|
        t.integer 	:receiver_id
        t.integer 	:sender_id
        t.string 		:format
        t.boolean   :read, :default=>false
        t.timestamps
      end
      add_index :notifications, :receiver_id
      add_index :notifications, :sender_id
    end

    def self.down
      drop_table :notifications
    end
  end