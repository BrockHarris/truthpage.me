class RemoveDobFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :dob
  end

  def down
    add_column :users, :dob, :date
  end
end
