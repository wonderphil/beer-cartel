class ApplicationMailer < ActionMailer::Base
  default from: "noreply-beer@seek.com.au",
  		  return_path: "noreply-beer@seek.com.au"


  layout 'mailer'
end