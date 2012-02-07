class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :email
      t.string :username
      t.date   :dob
      t.boolean :admin, :default=>false
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end

  def down
    drop_table :users
  end
end
