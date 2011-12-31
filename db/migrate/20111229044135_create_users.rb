class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :display
      t.string :email
      t.string :password
      t.string :dob

      t.timestamps
    end
  end
end
