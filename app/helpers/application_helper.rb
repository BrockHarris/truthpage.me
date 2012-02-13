module ApplicationHelper
  #def javascript(*args)
  #  content_for(:head) { javascript_include_tag(*args) }
  #end

  def render_user_avatar(user, size=:small, opts={})
    if user.photo.exists?
      return image_tag user.photo.url(size)
    else
      image_tag "genericpic-#{size}.jpg" 
    end
  end

  def render_feed_stamp(micropost)
    "#{link_to(micropost.user.username)} shared with #{link_to(micropost.target_user.username, user_path(micropost.target_user))} #{time_ago_in_words(micropost.created_at)} ago:".html_safe
  end

end