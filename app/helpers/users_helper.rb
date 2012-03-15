module UsersHelper
  
  def render_follow_links(user)
    return nil if user == current_user
    user.followable_by?(current_user) ? follow_link(user) : unfollow_link(user)
  end

  def follow_link(user, opts={})
    button_to "follow", follow_user_path(user), :class => 'follow_button'
  end

  def unfollow_link(user, opts={})
    button_to "unfollow", unfollow_user_path(user), :class => 'unfollow_button'
  end
end