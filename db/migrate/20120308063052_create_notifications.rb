class CreateNotifications < ActiveRecord::Migration
    def self.up
      create_table :notifications do |t|
        t.integer 	:receiver
        t.integer 	:sender
        t.string 		:format
        t.boolean   :read, :default=>false
        t.timestamps
      end
    end

    def self.down
      drop_table :notifications
    end
  end