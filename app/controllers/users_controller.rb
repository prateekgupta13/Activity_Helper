class UsersController < ApplicationController
 	before_filter :signed_in_user, only: [:index, :destroy]
	def show
		# @user=User.find(params[:id])
		@user = User.find_by_username(params[:id])
		@activity=Activity.new
		if @user.activities.present?
			@activities= @user.activities.paginate(page: params[:page])
		end
		@comment=Comment.new
		@comments=Comment.all
		@message=Message.new
		# @messages=current_user.messages;
		# @inverse_messages=current_user.inverse_messages;
		# @messages_all=@messages+@inverse_messages;

	end

	def index
			@user=current_user
			@users = User.without_user(current_user).paginate(page:params[:page])
	end 

end
