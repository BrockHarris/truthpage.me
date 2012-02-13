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
end