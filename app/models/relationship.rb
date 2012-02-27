class Relationship < ActiveRecord::Base
  attr_accessible :followed_id
  
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
  
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true

  default_scope where("relationships.deleted_at IS NULL")
  
  def destroy
    update_attribute(:deleted_at, Time.now.utc)
  end
end
