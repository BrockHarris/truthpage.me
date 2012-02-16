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
                    
  def to_param
    username
  end                   
  
  def self.search(search)
   if search
      where('username LIKE ? OR email LIKE ?', "%#{search}%","%#{search}%")
   else
      all
   end
  end

  def self.omniauth_find_or_create(omniauth)
    email     = omniauth['info']['email']
    username  = omniauth['info']['nickname'] || omniauth['info']['name']
    user = User.find_or_create_by_email_and_username(:email=>omniauth['info']['email'], :username=>omniauth['info']['nickname'] || omniauth['info']['name'])
    user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])
    user.save!
    user
  end
                    
  #returns the relationship object IF this object is followed by the supplied user argument.                                                                                 
  def following?(user)
    relationships.find_by_followed_id(user)
  end

  #adds a relationship object with this user object and the one supplied in the argument.
  def follow!(user)
    relationships.create!(:followed_id => user.id)
  end

  #deletes a relationship object with this user object and the one supplied in the argument.
  def unfollow!(user)
     relationships.find_by_followed_id(user).destroy
  end

  #returns a boolean if this user object can be followed by the one supplied in the argument.
  def followable_by?(user)
    return false if self.id == user.id #can't follow self
    return false if user.following?(self) #can't follow someone already following
    true #otherwise 
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

end

