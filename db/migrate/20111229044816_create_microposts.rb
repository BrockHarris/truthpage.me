class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :truth
      t.string :user_id

      t.timestamps
    end
  end
end
