module Authenticable

	# Devise methods overwrites
	def current_user
		@current_user ||= User.find_by(auth_token: request.headers['Authorization'])
	end

	def authenticate_with_token!
		render json: { "errors" => "Not authenticated" },
										 status: :unauthorized unless user_signed_in? 
	end

	def authorize_with_token!
		render json: { "errors" => "Not authorized, id: #{params[:id]}" },
										 status: :unauthorized unless same_user_signed_in?
	end

	def user_signed_in?
		current_user.present?
	end

	def same_user_signed_in?
		user_signed_in? && current_user.id == params[:id].to_i
	end
end
