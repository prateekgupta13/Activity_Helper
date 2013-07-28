require 'spec_helper'

describe "Activity" do

  let(:user) { FactoryGirl.create(:user) }
  before { @activity = user.activities.build(category: "Sports", name: "Cricket", description: "desc") }
  
  subject { @activity }

  it { should respond_to(:name) }
  it { should respond_to(:category) }
  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  
  
  its(:user) { should==user }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @activity.user_id = nil }
    it { should_not be_valid }
  end
  describe "with blank category" do
    before { @activity.category = " " }
    it { should_not be_valid }
  end
  describe "with blank name" do
    before { @activity.name = " " }
    it { should_not be_valid }
  end
  
  describe "with description that is too long" do
    before { @activity.description = "a" * 200 }
    it { should_not be_valid }
  end

  describe "comment associations" do
    before do
      @activity.save
    end

    let!(:c1){FactoryGirl.create(:comment, content:"wonderful1", user:user, activity:@activity, created_at: 1.hour.ago)}
    let!(:c2){FactoryGirl.create(:comment, content:"wonderful2", user:user, activity:@activity, created_at: 2.hour.ago)}      
    it "should have the right comments in the right order" do
      @activity.comments.should == [c1, c2]
    end

    it "should destroy associated comments" do
      comments = @activity.comments.dup
      @activity.destroy       
      comments.each do |comment|
        Comment.find_by_id(comment.id).should be_nil
      end
    end
  end
end