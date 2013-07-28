require 'spec_helper'

describe "Comment pages", :js => true  do 

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  
  before do
    sign_in user
  end

 describe "activity creation", :js => true do
    describe "with valid information" do
      before do
       select 'Sports', from: "Category"
       fill_in 'Name', with: "Cricket"
       fill_in 'Description', with: "Like"
       click_button "Create"
      end
      it{should have_content("Cricket")}

      describe "Comment creation" do
        describe "with valid information" do
          before do
            click_link "Comment?"
            fill_in 'comment_content', with: "Wonderful!"
            page.execute_script("$('#create-comment-form').submit()")
          end
          it{should have_content("Wonderful!")}
        end
      end
    end
  end
end