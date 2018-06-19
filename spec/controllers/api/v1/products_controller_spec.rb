require 'spec_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
	describe "GET #show" do
		before(:each) do
			@product = FactoryBot.create :product
			get :show, params: {id: @product.id}
		end

		it "returns the information about a reporter on a hash" do
			product_response = json_response[:data][:attributes]
			expect(product_response[:title]).to eql @product.title
		end

		it "has the user as an embedded object" do
			user_response = json_response[:included][0][:attributes]
			expect(user_response[:email]).to eql @product.user.email
		end

		it { should respond_with 200 }
	end

	describe "GET #index" do
		before(:each) do
			@count = 4
		end

		# context: when is not receiving any product_ids paramater
		context "when is not receiving any product_ids parameter" do
			before(:each) do
				@products_array = []
				@count.times { @products_array.push(FactoryBot.create :product) }
				get :index
			end

			it "returns 4 records from the database" do
				products_response = json_response[:data]
				expect(products_response.length).to eql @count
			end

			it "returns the product's relationship to the user object" do
				products_response = json_response[:data]
				products_response.each do |product_response|
					expect(product_response[:relationships][:user][:data][:id]).to be_present
				end
			end

			it "returns the user object inside each product" do
				@i = 0
				products_response = json_response[:data]
				users_response = json_response[:included]
				users_response.each do |user_response|
					expect(user_response[:attributes][:email]).to eql @products_array[@i].user.email
					@i += 1
				end
			end

			# for pagination
			it_behaves_like "pagination list"

			it { should respond_with 200}
		end

		context "when product_ids parameter is sent" do
			before(:each) do
				@user = FactoryBot.create :user
				@count.times { FactoryBot.create :product, user: @user }
				get :index, params: {product_ids: @user.product_ids}
			end

			it "returns just the products that belong to the user" do
				users_response = json_response[:included]
				users_response.each do |user_response|
					expect(user_response[:attributes][:email]).to eql @user.email
				end
			end

		end

	end

	describe "POST #create" do
		context "when is successfully created" do
			before(:each) do
				user = FactoryBot.create :user
				@product_attributes = FactoryBot.attributes_for :product
				api_authorization_header user
				post :create, params: { user_id: user.id, product: @product_attributes }
			end

			it "renders the json representation for the product record just created" do
				product_response = json_response[:data][:attributes]
				expect(product_response[:title]).to eql @product_attributes[:title]
			end

			it { should respond_with 201 }
		end

		context "when is not created" do
			before(:each) do
				user = FactoryBot.create :user
				@invalid_product_attributes = { title: "Smart TV", price: "twelve dollars" }
				api_authorization_header user
				post :create, params: { user_id: user.id, product: @invalid_product_attributes }
			end

			it "renders an errors json" do
				product_response = json_response
				expect(product_response).to have_key(:errors)
			end

			it "renders the json errors on why the product could not be created" do
				product_response = json_response
				expect(product_response[:errors][:price]).to include "is not a number"
			end

			it { should respond_with 422 }
		end
	end

	describe "PUT/PATCH #update" do
		before(:each) do
			@user = FactoryBot.create :user
			@product = FactoryBot.create :product, user: @user
			api_authorization_header @user
		end

		context "when is successfully updated" do
			before(:each) do
				patch :update, params: { user_id: @user.id, id: @product.id, product: { title: "An expensive TV" } }
			end

			it "renders the json representation of the updated user" do
				product_response = json_response[:data][:attributes]
				expect(product_response[:title]).to eql "An expensive TV"
			end

			it { should respond_with 200 }
		end

		context "when is not updated" do
			before(:each) do
				patch :update, params: { user_id: @user.id, id: @product.id, product: { price: "twelve dollars" } }
			end

			it "renders an errors json" do
				product_response = json_response
				expect(product_response).to have_key(:errors)
			end

			it "renders the json errors on why the user could not be updated" do
				product_response = json_response
				expect(product_response[:errors][:price]).to include "is not a number"
			end

			it { should respond_with 422 }
		end
	end

	context "DELETE #destroy" do
		before(:each) do
			@user = FactoryBot.create :user
			@product = FactoryBot.create :product, user: @user
			api_authorization_header @user
			delete :destroy, params: { user_id: @user.id, id: @product.id }
		end

		it { should respond_with 204 }
	end
end
