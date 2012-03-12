class Notification < ActiveRecord::Base
	 attr_accessible :sender_id, :receiver_id, :format, :read
   default_scope :order => 'notifications.created_at DESC'

   belongs_to :sender, :class_name=>"User"
   belongs_to :receiver, :class_name=>"User"

end