class AddSubscriptionsToUsers < ActiveRecord::Migration
  def change
  	 add_column :users, :rating_email, :boolean, :default => true
  	 add_column :users, :comment_email, :boolean, :default => true
  end
end
