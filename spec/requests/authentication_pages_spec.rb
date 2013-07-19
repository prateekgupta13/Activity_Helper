require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit new_user_session_path }
      describe "with invalid information" do
        before { click_button "Sign in" }
          it { should have_title('Sign in') }
          it { should have_selector('div', text: 'Invalid') }
      end
      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        it { should have_content(user.username) }
        it { should have_link('Profile', href: user_path(user)) }
        it { should have_link('Comment?'),href:'#'}
        it { should have_link('Logout', href: destroy_user_session_path) }
        it { should_not have_link('Sign in', href: new_user_session_path) }

        describe "followed by signout" do
          before { click_link "Logout" }
          it { should have_link('Sign in') }
        end
      end
  end


  # authorization to user to see pages
    describe "authorization" do

    describe "for non-signed-in users" do
        let(:user) { FactoryGirl.create(:user) }
      
        describe "in the Activities controller" do

          describe "submitting to the create action" do
          before { post user_activities_path(user) }
          specify { response.should redirect_to(new_user_session_path) }
          end

          describe "submitting to the destroy action" do
          before { delete user_activity_path(user,FactoryGirl.create(:activity)) }
          specify { response.should redirect_to(new_user_session_path) }
          end
        end
    end
  end
end