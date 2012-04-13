class AddContentToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :micropost_content, :string
  end
end
