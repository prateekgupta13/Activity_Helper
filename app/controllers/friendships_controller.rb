class FriendshipsController < ApplicationController
	before_filter :signed_in_user, only: [:create,:update,:destroy]
	def create
		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  		if @friendship.save
  			# Tell the UserMailer to send a welcome Email after save
        	UserMailer.welcome_email(@friendship.friend,current_user).deliver
    		flash[:notice] = "Requested for friendship."
    		redirect_to current_user
  		else
		    flash[:error] = "Unable to add friend."
		    redirect_to current_user
  		end
	end

	def update
		@friendship=Friendship.find(params[:id])
		@friendship.update_attribute(:status=>true)
		if @friendship.save
			flash[:notice] = "Friendship Accepted."
			redirect_to current_user
		else
			flash[:error] = "Unable to add friend."
		    redirect_to current_user
		end
	end


	def destroy
		@friendship = current_user.friendships.find(params[:id])
	  	@friendship.destroy
	  	flash[:notice] = "Removed friendship."
	  	redirect_to current_user
	end
	
end
