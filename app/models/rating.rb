class Rating < ActiveRecord::Base
	attr_accessible :micropost_id, :owner_id, :rater_id, :rating, :micropost_content
  
  belongs_to :micropost
  belongs_to :target_user, :class_name=>"User", :foreign_key=>"owner_id"
	belongs_to :user, :class_name=>"User", :foreign_key=>"rater_id"

	scope :trues, where("rating = ?", "true")
  scope :falses, where("rating = ?", "false")

  after_create :create_rating_notification

  after_save :update_micropost_truth_percentage

  def update_micropost_truth_percentage
    self.micropost.update_truth_percentage
  end

  def create_rating_notification
    unless self.rater_id==self.owner_id
      if self.rating=="true"
        Notification.create!(:sender_id=>self.rater_id, :receiver_id=>self.owner_id, :format=>"liked a truth about you.", :micropost_content=>self.micropost_content)
      else
        Notification.create!(:sender_id=>self.rater_id, :receiver_id=>self.owner_id, :format=>"disliked a truth about you.", :micropost_content=>self.micropost_content)
      end
    end
  end
end