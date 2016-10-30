class Api::V1::UsersController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead
	protect_from_forgery with: :null_session

	respond_to :json

	def show
		respond_with User.find(params[:id])
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status: 201, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end
