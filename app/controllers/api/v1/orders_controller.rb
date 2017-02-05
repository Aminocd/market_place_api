class Api::V1::OrdersController < ApplicationController
#	before_action :authenticate_with_token!
	before_action do
		authorize_with_token!(:user_id)
	end

	respond_to :json

	def index
		respond_with current_user.orders
	end
end
