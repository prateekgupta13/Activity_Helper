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
end