class CreateComments < ActiveRecord::Migration
  def self.up
      create_table :comments do |t|
        t.integer 	:micropost_id
        t.integer 	:user_id
        t.integer 	:owner_id
        t.string    :post_comment
        t.timestamps
      end
      add_index :comments, :micropost_id
      add_index :comments, :user_id
      add_index :comments, :owner_id
      add_index :comments, :created_at
    end

    def self.down
      drop_table :comments
    end
  end
