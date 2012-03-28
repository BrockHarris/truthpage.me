class Micropost < ActiveRecord::Base
  attr_accessible :content, :belongs_to_id, :anon, :notification_attributes

  belongs_to :user
  belongs_to :target_user, :class_name=>"User", :foreign_key=>"belongs_to_id" 

  has_many :ratings
  
  validates :content, :presence => true, :length => { :maximum => 250 }
  validates :user_id, :presence => true

  after_create :create_notification, :unless => :anon?
  after_create :create_anon_notification, :if => :anon?

  default_scope where("microposts.deleted_at IS NULL").order("microposts.created_at DESC")

  scope :from_users_followed_by, lambda { |user| followed_by(user) }
  scope :most_truthy, where("ratings.rating = 'true'")
                      .joins(:ratings)
                      .select("microposts.*, count(ratings.rating) AS truth_count")
                      .group("microposts.id")
                      .order("truth_count DESC")
  
  def destroy
    update_attribute(:deleted_at, Time.now.utc)
  end

  def create_notification
    Notification.create!(:sender_id=>self.user_id, :receiver_id=>self.belongs_to_id, :format=>"posted a truth about you")
  end

  def create_anon_notification
    Notification.create!(:noname=> true, :sender_id=>self.user_id, :receiver_id=>self.belongs_to_id, :format=>"posted a truth about you")
  end
  
  def rateable_by_user?(user)  
    self.ratings.where(:rater_id=>user.id).empty?
  end
  
  private

    # Return a SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
  end