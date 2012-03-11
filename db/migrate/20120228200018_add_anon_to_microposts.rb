class AddAnonToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :anon, :boolean
  end
end
