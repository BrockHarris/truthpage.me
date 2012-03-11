class AddDeletedAtToUsersAndDependents < ActiveRecord::Migration
  def change
   
    add_column :microposts, :deleted_at, :datetime
 
  end
end
