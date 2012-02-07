Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '186414394781001', 'f6ab9f3c9f20412ac03c56f4abff88a1'
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  #provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
   provider :identity, on_failed_registration: lambda { |env|    
    IdentitiesController.action(:new).call(env)
  }
end