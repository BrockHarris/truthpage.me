class AddRequestEmailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :request_email, :boolean, :default => true
  end
end
