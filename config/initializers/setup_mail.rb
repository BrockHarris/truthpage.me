ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "truthpage.me",  
  :user_name            => "support@truthpage.me",  
  :password             => "Truthpage1",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  