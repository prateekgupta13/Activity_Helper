class InverseFriendshipsController < ApplicationController
	before_filter :signed_in_user, only: [:destroy]

	def destroy
		@friendship = current_user.inverse_friendships.find(params[:id])
	  	if @friendship.destroy
	  	flash[:notice] = "Removed friendship."
	  else
	  	flash[:notice]="Unsuccessful in removing friendship"
	  end
	  	redirect_to current_user
	end
end
