class Rating < ActiveRecord::Base
	attr_accessible :micropost_id, :owner_id, :rater_id, :rating
  
  belongs_to :micropost
  belongs_to :target_user, :class_name=>"User", :foreign_key=>"owner_id"
	belongs_to :user, :class_name=>"User", :foreign_key=>"rater_id"

	scope :trues, where("rating = ?", "true")
  scope :falses, where("rating = ?", "false")
end
