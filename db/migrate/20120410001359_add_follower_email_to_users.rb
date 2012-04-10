class AddFollowerEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :follower_email, :boolean, :default => true
  end
end
