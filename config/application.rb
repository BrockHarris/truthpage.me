require 'will_paginate/array'
require File.expand_path('../boot', __FILE__)
require 'rails/all'
require 'rack/no-www'

WillPaginate.per_page = 30  #default to 30 globally.

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Truthpage
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.precompile += ['admin_data.css', 'admin_data.js']
    config.assets.version = '1.0'
    if Rails.env.production?
          config.middleware.insert_before Rack::Lock, Rack::NoWWW
    end
  end
end
