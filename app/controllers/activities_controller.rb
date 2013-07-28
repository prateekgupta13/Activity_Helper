class ActivitiesController < ApplicationController
 respond_to :html,:xml,:json
 before_filter :signed_in_user, only: [:create, :destroy, :index]
 # before_filter :correct_user,   only: [:new,:create, :destroy]	

  def new
  end

  def create
		@activity = current_user.activities.build(params[:activity])
    @comment=Comment.new
 		if @activity.save
      @activities= Activity.paginate(page: params[:page])
      respond_with do |format|
        format.html do
          if request.xhr?
            render partial: 'activity', layout:false, status: :created, locals: {nures: @activities}
          end
        end
      end
  	else
      @user = current_user
      respond_with do |format|
        format.html do
          if request.xhr?
            render partial: 'new', layout:false, status: :error, locals: {nure: @activity}
          end
        end
      end 
  	end
	end

	def destroy
	end

  def index
  end
end
