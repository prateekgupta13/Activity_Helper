class UserMailer < ActionMailer::Base

	default from: "bigcolors@akaruilabs.com"
 
	def welcome_email(user, from)
    	@user = user
    	@from=from
    	mail(to: @user.email, subject: 'Friend Request on Activity_Helper Site')
  	end
end