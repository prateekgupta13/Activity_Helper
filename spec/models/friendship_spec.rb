require 'spec_helper'

describe "Friendship" do

	let(:user1) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user) }
	before{
		
		@friendship=user1.friendships.build(:friend_id =>user2.id, status: true)
	}

	subject { @friendship }

	it { should respond_to(:user_id) }
    it { should respond_to(:friend_id) }
    it { should respond_to(:status)}
    it { should respond_to(:messages)}
    it { should respond_to(:user)}
    it { should respond_to(:friend)}
    
    
    
    it{ should be_valid}

    describe "when user_id is not present" do
	    before { @friendship.user_id = nil }
	    it { should_not be_valid }
	end

	describe "when friend_id is not present" do
	    before { @friendship.friend_id = nil }
	    it { should_not be_valid }
	end	

	# describe "messages Association" do
	# 	before {@friendship.save}
	# 	it "should destroy associated messages" do
 #    	  messages = @friendship.messages.dup
 #      		@friendship.destroy       
 #      		messages.each do |message|
	#         	Message.find_by_id(message.id).should be_nil
 #    	  	end
 #    	end
 #    end

	describe "either email send" do

		before do
			@friendship.save
			mail=UserMailer.welcome_email(@friendship.friend).deliver
			ActionMailer::Base.deliveries.last.to.should == [user2.email]
		end
		# ActionMailer::Base.deliveries.last{should (user2.email)}
		# ActionMailer::Base.deliveries.size.should == 1
	end

	
end
	   
