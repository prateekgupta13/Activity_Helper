describe "Activity pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "activity creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create an activity" do
        expect { click_button "Create" }.not_to change(Activity, :count)
      end

      describe "error messages" do
        before { click_button "Create" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before do
       select 'Sports', from: "Category"
       fill_in 'Name', with: "Cricket"
       fill_in 'Description', with: "Like"
      end
      it "should create an activity" do
        expect { click_button "Create" }.to change(Activity, :count).by(1)
      end
    end
  end
end