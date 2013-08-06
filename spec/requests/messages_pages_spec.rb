require 'spec_helper'

describe "Message Pages", :js=>true do
	subject { page }

	let(:user1) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	
	before do 
		sign_in user1
		@friendship=user1.friendships.build(user:user1, friend_id: user2.id, status: true)
	end

	describe "message creation" do
		before do 
			@friendship.save
			visit user_path(user2)
		end

		it {should have_title(user2.username)}
		it {should have_link("Friend")}
        it {should have_selector('input')}
		describe "with valid information" do
			before do
				fill_in 'message[message]', with:"Hi How Are You"
				click_button 'send'
			end
			it { should have_content("message created")}
			it {should have_title(user1.username)}

			describe "check message status" do
				before{click_link 'See Messages'}
				it{should have_content("Hi How Are You")}
			end
		end

		describe "with invalid information" do
			it "should not create message" do
          		 expect { click_button "send" }.not_to change(Message, :count)
        	end
        	describe "error messages" do
        		before { click_button "send" }
          		it { should have_content('message not created') } 
        	end
       	end
	end
end
