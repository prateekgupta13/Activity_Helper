require 'spec_helper'

describe "Comment" do

	let(:user) { FactoryGirl.create(:user) }
	let(:activity) { FactoryGirl.create(:activity, user:user) }
  
	before {
   		@comment = activity.comments.build(content: "wonderful") 
   		@comment.user=user
   	}
					
  	subject { @comment }

	it { should respond_to(:content)}
	it { should respond_to(:user_id) }
	it { should respond_to(:activity_id) }
	it { should respond_to(:user) }
	it { should respond_to(:activity) }
	its(:user) { should==user }
	its(:activity) { should==activity }  
	it { should be_valid }

	describe "when user_id is not present" do
		before { @comment.user_id = nil }
		it { should_not be_valid }
	end

	describe "when activity_id is not present" do
		before { @comment.activity_id = nil }
		it { should_not be_valid }
	end
	
	describe "with blank content" do
		before { @comment.content = " " }
		it { should_not be_valid }
	end

	describe "with content that is too long" do
		before { @comment.content = "a" * 200 }
		it { should_not be_valid }
	end
end
  
