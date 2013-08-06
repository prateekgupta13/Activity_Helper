require 'spec_helper'

describe "Friendship pages", :js=>true do

subject { page }

  
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  
  	describe "Adding  a friendship" do
	    before do      
        
        sign_in user1
        	visit user_path(user2) 
      	end	        
	    it { should have_selector('h1',    text: user2.username) }
	  	it { should have_title(user2.username) }
	  	it {should have_link("Add Friend")}
	    it "should request the friendship" do
	       expect do
	        click_link "Add Friend"  
	        	end.to change(Friendship, :count).by(1)            
    	end
    	describe "after requesting the user" do
          before { click_link "Add Friend" }
          	it {should have_content("Requested for friendship")}
            it {should have_title(user1.username) }
      end
    end
    # describe "checking friendship status" do
    # 	before do 
    # 		@friendship=user1.friendships.build(:friend_id =>user2.id)
    # 		@friendship.save
    # 		visit user_path(user2)
    # 	end
    # 	it {should have_link("Friend Request Pending")}
    # 	it {should have_content(user1.username)}
    # end

    describe "accepting/decline friendship" do
      before do
        @friendship=user1.friendships.build(user:user1, friend_id: user2.id)
        @friendship.save
        sign_in user2
        visit user_path(user2)

      end
      it {should have_content(user2.username)}
      it {should have_content(user1.username)}
      it {should have_link('Accept')}
      it {should have_link('Decline')}
    end

    # describe "Accept friendship" do
    #     before do
    #     @friendship=user1.friendships.build(user:user1, friend_id: user2.id)
    #     @friendship.save
    #     sign_in user2
    #     visit user_path(user2)
    #     end
    #     it{ should have_content(user2.username)}
    #     it{ should have_link('Accept')}
    #     # it{should have_content('Friendship Accepted')}
    # end      
end

    

  # describe "accepting/decline friendship" do
  #     before do 
  #       @friendship=user1.friendships.build(:friend_id =>user2.id)
  #       @friendship.save
  #       click_link 'Logout'
  #       sign_in user2
  #       visit user_path(user2)
  #     end
  #     it {should have_link("Friend Request Pending")}
  #     it {should have_content(user1.username)}
  #     it {should have_link('Accept', href:friendship_path(inverse_friendship), method: :put)}
  #     it {should have_link('Decline', href:friendship_path(inverse_friendship), method: :delete)}
  #   end

	# describe "Friend request pending" do
 #    	before do
 #    		@friendship=user1.friendships.build(:friend_id =>user2.id)
 #    	end
 #    	before do
 #    		@friendship.save!	
 #    	end
 #    	before {visit user_path(user2)}
 #     	it { should have_selector('h1',    text: user2.username) }
 #   		it { should have_title(user2.username) }
 #   		it {should have_link("Friend Request Pending")}
# end  
	# describe "Already Friend" do
 #    	before do
 #    		@friendship=user1.friendships.build(:friend_id =>user2.id, :status=>true)
 #    	end
 #    	before do
 #    		@friendship.save!	
 #    	end
 #    	before {visit user_path(user2)}
 #     	it { should have_selector('h1',    text: user2.username) }
 #   		it { should have_title(user2.username) }
 #   		it {should have_link("Friend")}
	# end  




