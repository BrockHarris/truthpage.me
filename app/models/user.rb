require 'digest'
class User < ActiveRecord::Base
  has_many :authorizations
  
  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id",
                             :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                     :class_name => "Relationship",
                                     :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

    
  def self.search(search)
   if search
      where('name LIKE ?', "%#{search}%")
   else
      all
   end
  end

  #temp..
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
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
    username
  end
end