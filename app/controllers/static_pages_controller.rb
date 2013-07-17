class StaticPagesController < ApplicationController
  	def home
  		if signed_in?
  			@user = current_user
        	@activity  = current_user.activities.build
        	@activities= Activity.paginate(page: params[:page])
	  	end
	end

  	def activity
  	end
end
