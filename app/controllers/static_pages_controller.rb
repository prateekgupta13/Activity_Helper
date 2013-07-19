class StaticPagesController < ApplicationController
	def home
		if signed_in?
			@user = current_user
    	@activity  = current_user.activities.build
    	@activities = Activity.paginate(page: params[:page])
      @comment=Comment.new
      @comments=Comment.all

   	end
  end

	def activity
	end
end
