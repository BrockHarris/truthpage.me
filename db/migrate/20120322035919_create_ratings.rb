class CreateRatings < ActiveRecord::Migration
  def self.up
      create_table :ratings do |t|
        t.string 	  :post_id
        t.integer 	:owner_id
        t.integer 	:rater_id
        t.string    :rating
        t.timestamps
      end
      add_index :ratings, :post_id
      add_index :ratings, :owner_id
      add_index :ratings, :rater_id
    end

    def self.down
      drop_table :ratings
    end
  end
