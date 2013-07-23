require 'spec_helper'

describe "Friendship" do

	let(:user1) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	before{
		
		@friendship=user1.friendships.build(:friend_id =>user2.id)
	}

	subject { @friendship }

	it { should respond_to(:user_id) }
    it { should respond_to(:friend_id) }
    it{ should be_valid}

    describe "when user_id is not present" do
	    before { @friendship.user_id = nil }
	    it { should_not be_valid }
	end

	describe "when friend_id is not present" do
	    before { @friendship.friend_id = nil }
	    it { should_not be_valid }
	end

	
end
	   
