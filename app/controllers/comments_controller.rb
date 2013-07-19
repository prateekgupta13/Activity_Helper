class CommentsController < ApplicationController

 respond_to :html,:xml,:json
 before_filter :signed_in_user, only: [:create, :destroy]

	def new
	end

	def create
    @user = User.find_by_username(params[:user_id])
    @activity=@user.activities.find(params[:activity_id])
    @comment=@activity.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      @comments=Comment.all
      respond_with do |format|
        format.html do
          if request.xhr?
            render partial: 'comment', layout:false, status: :created, locals:{activity:@activity,comments:@comments}
          end
        end
      end
    else
      # @user = current_user
      # @activity=current_user.activities.find(params[:activity_id])
      # @comment=@activity.comments.build(params[:comment])
      # @comment.user = current_user
      respond_with do |format|
        format.html do
          if request.xhr?
            render partial: 'new', layout:false, status: :error, locals:{activity:@activity,comment:@comment}
          end
        end
      end 
    end
  end


	def index
	end
	

	private

  	def signed_in_user
    	unless signed_in?
        # store_location
        redirect_to new_user_session_path, notice: "Please sign in."
    	end
  	end  
  end
