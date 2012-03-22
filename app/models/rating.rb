class Rating < ActiveRecord::Base
	attr_accessible :post_id, :owner_id, :rater_id, :rating
 belongs_to :micropost, :class_name=>"Micropost", :foreign_key=>"post_id" 
end
