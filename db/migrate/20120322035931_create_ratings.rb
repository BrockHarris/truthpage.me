class CreateRatings < ActiveRecord::Migration
  def self.up
      create_table :ratings do |t|
        t.integer 	:micropost_id
        t.integer 	:owner_id
        t.integer 	:rater_id
        t.string    :rating
        t.timestamps
      end
      add_index :ratings, :micropost_id
      add_index :ratings, :owner_id
      add_index :ratings, :rater_id
    end

    def self.down
      drop_table :ratings
    end
  end
