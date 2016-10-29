class Api::V1::UsersController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead
	protect_from_forgery with: :null_session

	respond_to :json

	def show
		respond_with User.find(params[:id])
	end
end
