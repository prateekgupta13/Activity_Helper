describe "Comment pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:activity){ FactoryGirl.create(:activity, user:user)}
  before { sign_in user }

  describe "Comment creation", :js => true do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a Comment for an activity" do
        expect { click_button "Create" }.not_to change(Comment, :count)
      end

      describe "error messages for comment" do
        before { click_button "Create" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before do
        fill_in 'Content', with: "Wonderful!"
        click_button "Create"
      end
        it{should have_content("Wonderful!")}
       # it "should create an activity" do
       #  expect { click_button "Create" }.to change(Activity, :count).by(1)
       # end
    end
  end
end