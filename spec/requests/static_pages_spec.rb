require 'spec_helper'

describe "Static pages" do
	subject { page }
	describe "Home Page" do
		before{ visit root_path}
    	it {should have_selector('h1', text: 'Home Page')}
    	it {should have_title("Welcome to Activity_Helper")}
  		it {should_not have_title('| Home')}
  		it {should have_link('Register')}
  		it {should have_link('Sign in')}
  		it {should have_selector('input')} 	

      describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:activity, user: user, category: "Sports", name: "Cricket", description: "I like") 
        FactoryGirl.create(:activity, user: user, category: "Music", name: "Bollywood", description: "I like")
        sign_in user
        visit root_path
      end

      it "should render the user's activity" do
        user.activities.each do |activity|
          page.should have_content(activity.category)
        end
      end
    end 		
  end
end


