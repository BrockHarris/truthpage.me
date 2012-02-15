class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates :name, :uniqueness=>true,
                   :presence => true, 
                   :format => { :with => /^\w*$/,
                                :message => "can contain only letters, digits or underscores." }
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_uniqueness_of :email
  has_one :authentication, :foreign_key=>"id"

  before_validation :downcase_name

  def downcase_name
    self.name = self.name.downcase
  end
 
end