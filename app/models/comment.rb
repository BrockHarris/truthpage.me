class Comment < ActiveRecord::Base
	attr_accessible :micropost_id, :user_id, :owner_id, :post_comment
	belongs_to :user
	validates :post_comment, :presence => true, :length => { :maximum => 120 }
	
	after_create :create_notification
	
	def create_notification
    Notification.create!(:sender_id=>self.user_id, :receiver_id=>self.owner_id, :format=>"commented on a truth about you.")
  end
end
