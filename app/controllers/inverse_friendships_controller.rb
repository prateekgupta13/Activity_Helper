class InverseFriendshipsController < ApplicationController
	before_filter :signed_in_user, only: [:destroy]

	def destroy
		@friendship = current_user.inverse_friendships.find(params[:id])
	  	@friendship.destroy
	  	flash[:notice] = "Removed friendship."
	  	redirect_to current_user
	end
end
