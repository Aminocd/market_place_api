require 'spec_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
	describe "GET #index" do
		before(:each) do
			current_user = FactoryGirl.create :user
			api_authorization_header current_user.auth_token
			4.times { FactoryGirl.create :order, user: current_user }
			get :index, user_id: current_user.id
		end

		it "returns 4 order records from the user" do
			order_response = json_response[:data]
			expect(order_response.length).to eql 4 
		end

		it { should respond_with 200}
	end

	describe "GET #show" do
		before(:each) do
			current_user = FactoryGirl.create :user
			api_authorization_header current_user.auth_token
			@order = FactoryGirl.create :order, user: current_user
			get :show, user_id: current_user.id, id: @order.id
		end

		it "it returns the user order record matching the id" do
			order_response = json_response[:data]
			expect(order_response[:id].to_i).to eql @order.id
		end

		it { should respond_with 200 }
	end

	describe "POST #create" do
		before(:each) do
			@current_user = FactoryGirl.create :user
			api_authorization_header @current_user.auth_token

			@product1 = FactoryGirl.create :product
			@product2 = FactoryGirl.create :product
			order_params = { product_ids: [@product1.id, @product2.id]}
			post :create, user_id: @current_user.id, order: order_params		
		end

		it "returns user order just created" do
			order_response = json_response[:data]
			expect(order_response[:id].to_i).to be_present
		end

		it { should respond_with 201 }
	end

	describe "set_total!" do
		before(:each) do
			@product1 = FactoryGirl.create :product, price: 85
			@product2 = FactoryGirl.create :product, price: 100		
			
			@order = FactoryGirl.build :order, product_ids: [@product1.id, @product2.id]
		end

		it "returns the total amount to pay for the products" do
			expect{@order.set_total!}.to change{@order.total}.from(0).to(185)
		end	
	end
end
