class AddMailSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_subscription, :boolean, :default => true
  end
end
