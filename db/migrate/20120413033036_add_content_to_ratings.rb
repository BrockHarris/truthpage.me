class AddContentToRatings < ActiveRecord::Migration
  def change
  	add_column :ratings, :micropost_content, :string
  end
end
