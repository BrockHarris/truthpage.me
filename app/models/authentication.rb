class Authentication < ActiveRecord::Base
  belongs_to :identity, :foreign_key=>"uid"
  belongs_to :user

  before_destroy :delete_associated

  def delete_associated
    identity.destroy
  end
end

