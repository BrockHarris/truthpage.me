class AddTruthPercentageToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :truth_percentage, :integer
  end
end
