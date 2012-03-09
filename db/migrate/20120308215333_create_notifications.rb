class CreateNotifications < ActiveRecord::Migration
    def self.up
      create_table :notifications do |t|
        t.string 	  :receiver
        t.string 	  :sender
        t.string 		:format
        t.boolean   :read, :default=>false
        t.timestamps
      end
    end

    def self.down
      drop_table :notifications
    end
  end