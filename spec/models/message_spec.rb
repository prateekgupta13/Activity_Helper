 require 'spec_helper'

 describe "Message" do

 	let(:user1) { FactoryGirl.create(:user) }
 	let(:user2) { FactoryGirl.create(:user) }
 	let(:friendship){ FactoryGirl.create(:friendship, user:user1, friend_id:user2.id, status:true)}

 	before{

 		@message=user1.messages.build(message:"hi", recipient_id: user2.id)
 	}

 	subject{@message}

 	it { should respond_to(:message) }
	it { should respond_to(:user_id) }
	it { should respond_to(:recipient_id) }
	it { should respond_to(:user) }
	it { should respond_to(:friendship) }
	

	
	it { should be_valid }

	describe "when user_id is not present" do
		before { @message.user_id = nil }
		it { should_not be_valid }
	end	

	describe "when recipient_id is not present" do
		before { @message.recipient_id = nil }
		it { should_not be_valid }
	end

	describe "when message is blank" do
		before { @message.message = " " }
		it { should_not be_valid }
	end

	describe "when message is not present" do
		before { @message.message = nil }
		it { should_not be_valid }
	end

	describe "when message is too long" do
		before { @message.message = "a"*51 }
		it { should_not be_valid }
	end

end

