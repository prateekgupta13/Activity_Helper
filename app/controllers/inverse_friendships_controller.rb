class InverseFriendshipsController < ApplicationController
	def destroy
		@friendship = current_user.inverse_friendships.find(params[:id])
	  	@friendship.destroy
	  	flash[:notice] = "Removed friendship."
	  	redirect_to current_user
	end
end
