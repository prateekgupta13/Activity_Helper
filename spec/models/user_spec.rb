require 'spec_helper'

describe User do

	before do
		@user = User.new(username:"Prateek", name: "Prateek", email: "user@example.com", 
		               password: "foobared", password_confirmation: "foobared")
	end

	subject { @user }

    it { should respond_to(:username) }
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:activities) }
	it { should respond_to(:comments) }
	it { should respond_to(:friendships) }
	it { should respond_to(:inverse_friendships) }
	it { should respond_to(:friends) }
	it { should respond_to(:inverse_friends) }
		
	it { should be_valid }

	 describe "when username is not present" do
     	before { @user.username = " " }
     	it { should_not be_valid }
   	end

    describe "when username is too long" do
  		before {@user.username="a"*50}
  		it {should_not be_valid}
	end

	describe "when username is already taken" do
		before do
			user_with_same_username=@user.dup
			user_with_same_username.save
		end
		it{should_not be_valid}
	end


	describe "when email is not present" do
		before {@user.email=" "}
		it {should_not be_valid}
	end

	describe "when email format is not valid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		    addresses.each do|invalid_address|
		   	@user.email=invalid_address
		   	@user.should_not be_valid
		   	end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
				addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn foo@bar+baz.com foo@bar_baz.com]
			addresses.each do |valid_address|
				@user.email=valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email=@user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it {should_not be_valid}
	end

	describe "when password is not present" do
		before {@user.password=@user.password_confirmation=" "}
		it {should_not be_valid}
	end

	describe "when password not match confirm password" do
		before {@user.password_confirmation="mismatch"}
		it {should_not be_valid}
	end

	describe "when password_confirmation is nil" do
		before {@user.password_confirmation=nil}
		it {should be_valid}
	end

	describe "when password is too short" do
		before {@user.password=@user.password_confirmation="a"*7}
		it {should be_invalid}
	end

	describe "activity associations" do
		before { @user.save }
	    let!(:older_activity) do 
	      FactoryGirl.create(:activity, user: @user, created_at: 1.day.ago)
	    end
	    let!(:newer_activity) do
	      FactoryGirl.create(:activity, user: @user, created_at: 1.hour.ago)
	    end

	    it "should have the right activities in the right order" do
	      @user.activities.should == [newer_activity, older_activity]
	    end

	    it "should destroy associated activities" do
	      activities = @user.activities.dup
	      @user.destroy	      
	      activities.each do |activity|
	        Activity.find_by_id(activity.id).should be_nil
	      end
    	end
  	end
end
 

