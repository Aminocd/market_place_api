module Authenticable
	#Ben 6/19/2018 You dont need thses any more since they were overrides for devise methods for another token strategy the new JWT startegy ive included ensures you dont have to worry about overriding these.
	# Devise methods overwrites
	def current_user
		@current_user ||= User.find_by(auth_token: request.headers['Authorization'])
	end

	def authenticate_with_token!
		render json: { "errors" => "Not authenticated" },
										 status: :unauthorized unless user_signed_in?
	end

	def authorize_with_token!(key)
		render json: { "errors" => "Not authorized, user_id: #{params[key]}, key var: #{key}" },
										 status: :unauthorized unless same_user_signed_in?(key)
	end

	def user_signed_in?
		current_user.present?
	end

	def same_user_signed_in?(key)
		user_signed_in? && current_user.id == params[key].to_i
	end
end
