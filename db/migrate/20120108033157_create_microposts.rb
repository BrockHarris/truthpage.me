class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
      t.integer :profile_id
      t.integer :belongs_to_id
      t.timestamps
    end
    add_index :microposts, [:user_id, :profile_id, :created_at]
  end

  def self.down
    drop_table :microposts
  end
end