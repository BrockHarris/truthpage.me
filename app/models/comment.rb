class Comment < ActiveRecord::Base
	attr_accessible :micropost_id, :user_id, :post_comment

	belongs_to :user

	validates :post_comment, :presence => true, :length => { :maximum => 120 }
end
