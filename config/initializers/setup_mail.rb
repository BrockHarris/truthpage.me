ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.sendgrid.net",  
  :port                 => 587,  
  :domain               => "truthpage.me",  
  :user_name            => "truthpage",  
  :password             => "yiuwOaz9",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  