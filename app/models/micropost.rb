class Micropost < ActiveRecord::Base

belongs_to :user
validates :truth, :length => { :maximum => 250 }
end
