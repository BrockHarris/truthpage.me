class Micropost < ActiveRecord::Base
  attr_accessible :content, :belongs_to_id, :anon, :notification_attributes, :truth_percentage

  belongs_to :user
  belongs_to :target_user, :class_name=>"User", :foreign_key=>"belongs_to_id" 

  has_many :ratings
  has_many :comments
  
  validates :content, :presence => true, :length => { :maximum => 250 }
  validates :user_id, :presence => true

  after_create :create_notification, :unless => :anon?
  after_create :create_anon_notification, :if => :anon?

  default_scope where("microposts.deleted_at IS NULL")

  scope :rated, where("microposts.truth_percentage > 0")
  scope :count_order, order("microposts.truth_percentage DESC")
  
  scope :order, order("microposts.created_at DESC")
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  
  def destroy
    update_attribute(:deleted_at, Time.now.utc)
  end

  def create_notification
    Notification.create!(:sender_id=>self.user_id, :receiver_id=>self.belongs_to_id, :format=>"posted a truth about you.", :micropost_content=>self.content)
  end

  def create_anon_notification
    Notification.create!(:noname=> true, :sender_id=>self.user_id, :receiver_id=>self.belongs_to_id, :format=>"posted a truth about you.", :micropost_content=>self.content)
  end
  
  def rateable_by_user?(user)  
    self.ratings.where(:rater_id=>user.id).empty?
  end

  def update_truth_percentage
    count = self.ratings.trues.count
    connection.execute("UPDATE microposts SET truth_percentage = #{count} WHERE id = #{self.id}")
  end
  
  private

  def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids})",
            { :user_id => user })
  end
end