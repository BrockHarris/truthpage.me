AdminData.config do |config|
  config.is_allowed_to_view = lambda {|controller| return true if current_user.admin  }
  config.is_allowed_to_update = lambda {|controller| return true if current_user.admin  }
end