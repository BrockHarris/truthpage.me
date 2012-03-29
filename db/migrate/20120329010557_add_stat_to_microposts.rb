class AddStatToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :stat, :varchar
  end
end
