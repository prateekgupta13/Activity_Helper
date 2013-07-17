require 'spec_helper'

describe "User pages" do
  subject { page }
  describe "signup" do

    before { visit new_user_registration_path }

      it { should have_selector('h2', text: 'Sign up') }
      it { should have_title('Sign up') }
      let(:submit) { "Sign up" }

      describe "with invalid information" do
        it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
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
      end
  end 
  
  let(:user) { FactoryGirl.create(:user) }   
  describe "Profile page" do
    let!(:a1) { FactoryGirl.create(:activity, user: user)}
    let!(:a2) { FactoryGirl.create(:activity, user: user)}

    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_title(user.name) }

    describe "activities" do
      it { should have_content(a1.category) }
      it { should have_content(a2.category) }
      it { should have_content(user.activities.count) }
    end
  end 
end

