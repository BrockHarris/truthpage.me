class Notification < ActiveRecord::Base
	  attr_accessible :sender, :receiver, :format, :read
  	
  

  default_scope :order => 'notifications.created_at DESC'

end