class UserMailer < ActionMailer::Base

	
 
	def welcome_email(user, from)
    	@user = user
    	@from=from
    	mail(to: @user.email, subject: 'Friend Request on Activity_Helper Site', from: @from.email)
  	end
end
