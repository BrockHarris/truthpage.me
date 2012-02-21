AdminData.config do |config|
  config.is_allowed_to_view = lambda {|controller|  if current_user.admin = true }
  config.is_allowed_to_update = lambda {|controller| if current_user.admin = true }
end