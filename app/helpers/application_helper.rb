module ApplicationHelper
  #def javascript(*args)
  #  content_for(:head) { javascript_include_tag(*args) }
  #end

  def render_true_ratings(micropost)
    "#{micropost.ratings.trues.count}".html_safe
  end

  def render_false_ratings(micropost)
    "#{micropost.ratings.falses.count}".html_safe
  end

  def render_user_avatar(user, size=:small, opts={})
    if user.photo.exists?
      return image_tag user.photo.url(size)
    else
      image_tag "genericpic-#{size}.jpg" 
    end
  end

  def render_follow_avatar(user, size=:tiny, opts={})
    if user.photo.exists?
      return image_tag user.photo.url(size)
    else
      image_tag "genericpic-#{size}.jpg" 
    end
  end

  #TODO: include all helpers in app_ctrlr.rb and move these to the microposts helper module. 
  def render_feed_stamp(micropost)
    if micropost.try(:anon?)
  	  "anonymously shared with #{link_to(micropost.target_user.username, micropost.target_user.username)}".html_safe
  	 else
    "#{link_to(micropost.user.username, micropost.user.username)} shared with #{link_to(micropost.target_user.username, micropost.target_user.username)}".html_safe
   end
  end
  
  def render_smallfeed_stamp(micropost)
     "shared with #{link_to(micropost.target_user.username, micropost.target_user.username)}".html_safe
  end

  def render_micropost_delete(micropost)
    #assuming that an admin or the creator can delete his own post. What about the target, can he?
    if current_user && (current_user==micropost.target_user || current_user==micropost.user)
      label = ""
      link_to label, micropost, :method => :delete,
                                :confirm => "are you sure you want to delete this?",
                                :title => micropost.content, 
                                :class => "delete_link"
    end                             
  end

end