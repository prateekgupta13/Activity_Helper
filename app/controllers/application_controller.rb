class ApplicationController < ActionController::Base
  protect_from_forgery
	# def after_sign_in_path_for(resource)
 #    	user_path(current_user)
	# end

  private

  def signed_in_user
       unless signed_in?
        # store_location
        redirect_to root_path, notice: "Please sign in."
      end
  end
end
