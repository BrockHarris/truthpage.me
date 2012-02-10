require 'digest'
class User < ActiveRecord::Base
  has_many :authentications, :dependent=>:destroy
  has_many :identities, :through=>:authentications
  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id",
                             :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                     :class_name => "Relationship",
                                     :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  has_attached_file :photo,
                    :styles => {
                    :thumb=> "50x50#",
                    :small  => "220x220>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename"  
  
  def self.search(search)
   if search
      where('username LIKE ? OR email LIKE ?', "%#{search}%","%#{search}%")
   else
      all
   end
  end
                                                                                   
  def following?(followed)
      relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
      relationships.create!(:followed_id => followed.id)
  end
    
  def unfollow!(followed)
     relationships.find_by_followed_id(followed).destroy
  end
  
  def feed
      Micropost.from_users_followed_by(self)
  end
  
  def globalfeed
    Micropost.from_users
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def name
    User.name
  end

end

