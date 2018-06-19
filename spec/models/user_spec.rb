require 'spec_helper'

describe User do
	before { @user = FactoryBot.build(:user)}

	subject { @user }

	it { should respond_to(:email)}
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:provider)}
	it { should respond_to(:uid)}
	# it { should respond_to(:auth_token)}

	it { should be_valid}

	it { should validate_presence_of(:email)}
#	it { should validate_uniqueness_of(:email)} # Shoulda Matcha validates email uniqueness incorrectly, does not ignore case
#	it { should validate_confirmation_of(:password)}
	it { should allow_value('example@domain.com').for(:email)}
# it { should validate_uniqueness_of(:auth_token)} #Ben Dont need this anymore

	it { should have_many(:products) }
	it { should have_many(:orders)}
	it { should have_many(:whitelisted_jwts)}

	# describe "#generates_authentication_token!" do
	# 	it "generates a unique token" do
	# 		Devise.stub(:friendly_token).and_return("auniquetoken123")
	# 		@user.generate_authentication_token!
	# 		expect(@user.auth_token).to eql "auniquetoken123"
	# 	end
	#
	# 	it "generates another token when one already has been taken" do
	# 		existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
	# 		@user.generate_authentication_token!
	# 		expect(@user.auth_token).not_to eql existing_user.auth_token
	# 	end
	# end

	describe "when email is not present" do
		before { @user.email = " "}
		it {should_not be_valid}
	end

	describe "#products associaton" do
		before do
			@user.save
			3.times { FactoryBot.create :product, user: @user }
		end

		it "destroys the associated products on self destruct" do
			@products = @user.products
			@user.destroy
			@products.each do |product|
				expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
			end
		end
	end
end
