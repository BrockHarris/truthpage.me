class AddBlurbToUser < ActiveRecord::Migration
  def change
    add_column :users, :blurb, :varchar
  end
end
