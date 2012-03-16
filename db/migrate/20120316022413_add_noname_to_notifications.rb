class AddNonameToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :noname, :boolean, :default => false
  end
end
