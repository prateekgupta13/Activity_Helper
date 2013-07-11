require 'spec_helper'

describe "User pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  # describe "profile page" do
    
  #   before { visit user_path(user) }

  #   it { should have_selector('h1',    text: user.name) }
  #   it { should have_selector('title', text: user.name) }
  # end
  
  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
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
end

