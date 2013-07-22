class UsersController < ApplicationController

	def show
		# @user=User.find(params[:id])
		@user = User.find_by_username(params[:id])
		@activity=Activity.new
		@activities= @user.activities.paginate(page: params[:page])
		@comment=Comment.new
		@comments=Comment.all
	end
end
