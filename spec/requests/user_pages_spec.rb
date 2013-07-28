require 'spec_helper'

describe "User pages", :js=>true do
  subject { page }
  
  describe "signup page" do

    before { visit new_user_registration_path }

      it { should have_selector('h2', text: 'Sign up') }
      it { should have_title('Sign up') }
      let(:submit) { "Sign up" }

      describe "with invalid information" do
        it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do
          before { click_button submit }
          it { should have_title('Sign up') }
          it { should have_content('error') }
        end
      end

      describe "with valid information" do
        before do

          fill_in "Username",     with: "Example"
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar123"
          fill_in "Password confirmation", with: "foobar123"
        end
        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }
          let(:user) { User.find_by(email: 'user@example.com') }
          it { should have_title(user.username) }
          it { should have_link("view my profile") }
          it { should have_content(user.activities.count) }
          it { should have_content('Welcome') }
        end
      end
  end 
  
  
  describe "Profile page" do

    let(:user) { FactoryGirl.create(:user) }   
    let!(:a1) { FactoryGirl.create(:activity, user: user)}
    let!(:a2) { FactoryGirl.create(:activity, user: user)}

    before do
     sign_in user
     visit user_path(user) 
   end
    it { should have_selector('h1',    text: user.username) }
    it { should have_title(user.username) }
    it { should have_content(user.activities.count) }
    it { should have_link("See Messages") }

    describe "activities" do
      it { should have_content(a1.category) }
      it { should have_content(a2.category) }
      it { should have_content(user.activities.count) }
    end
  end 
end

