require 'will_paginate/array'
require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  
  Bundler.require(*Rails.groups(:assets => %w(development test)))
 
end

module Truthpage
  class Application < Rails::Application
   
   
    config.encoding = "utf-8"

    
    config.filter_parameters += [:password]

  
    config.assets.enabled = true

    
    config.assets.version = '1.0'
  end
end
