module UsersHelper

  def gravatar_for(user, options = { :size => 50 })

    gravatar_image_tag(user.email.try(:downcase), :alt => h(user.username),

                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end