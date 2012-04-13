class AddContentToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :micropost_content, :string
  end
end
