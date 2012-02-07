Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '186414394781001', 'f6ab9f3c9f20412ac03c56f4abff88a1'
  provider :twitter, 'akOOojiNsQRXyKW3IrINxA', 'dgZ09rZC7c0WJfXF45GtLX23f1I5OQnOa4k5JNe538'
  provider :google_oauth2, '892785099521.apps.googleusercontent.com', 'pJCmfpRSdGzmTK4kL2QOJ_ae', {access_type: 'online', approval_prompt: ''}
  provider :identity, on_failed_registration: lambda { |env|    
    IdentitiesController.action(:new).call(env)
  }
end