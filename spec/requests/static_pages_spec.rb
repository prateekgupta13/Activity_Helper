require 'spec_helper'

describe "Static pages" do
	subject { page }
	describe "Home Page" do
		before{ visit root_path}
    	it {should have_selector('h1', text: 'Home Page')}
    	it {should have_title("Welcome to Activity_Helper")}
  		it {should_not have_title('| Home')}
  		it {should have_link('Activity')}
  		it {should have_link('Register')}
  		it {should have_link('Sign in')}
  		it {should have_selector('input')} 	
  		
  	end

	describe "Activity Page" do
		before{ visit activity_path}
    	it {should have_selector('h1', text: 'Activity Page')}
    	it {should have_title("Activity Page")}
  	end

end


