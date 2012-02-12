module UsersHelper

  def gravatar_for(user, options = { :size => 50 })

    gravatar_image_tag(user.email.try(:downcase), :alt => h(user.username),

                                            :class => 'gravatar',
                                            :gravatar => options)
  end 

  def render_follow_links(user)
    return nil if user == current_user
    user.followable_by?(current_user) ? follow_link(user) : unfollow_link(user)
  end

  def follow_link(user, opts={})
    button_to "follow", follow_user_path(user)
  end

  def unfollow_link(user, opts={})
    button_to "stop following", unfollow_user_path(user)
  end
end