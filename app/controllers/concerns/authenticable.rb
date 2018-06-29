module Authenticable
	extend ActiveSupport::Concern
	included do
		include AuthenticationHelper
		respond_to :json, if: -> { devise_controller?}
		skip_before_action :verify_authenticity_token, if: -> {devise_controller? && request.format.json?}
		prepend_before_action :require_no_authentication, only: [:create], if: -> { devise_controller?}
		prepend_before_action :configure_sign_up_params, only: [:create], if: -> { devise_controller? }
	end

	protected
	def after_sign_in_path_for(resource)
     request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

	def root_path
    ENV.fetch("FRONT_END_PATH") {'/'}
  end

	private
	def ensure_params_exist
     return unless params[:user].blank?
     missing_param_error("missing user parameter")
  end

	def configure_sign_up_params
    ensure_params_exist
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

	#Ben 6/19/2018 You dont need these any more since they were overrides for devise methods
	# Devise methods overwrites
	# def current_user
	# 	@current_user ||= User.find_by(auth_token: request.headers['Authorization'])
	# end
	#
	# def authenticate_with_token!
	# 	render json: { "errors" => "Not authenticated" },
	# 									 status: :unauthorized unless user_signed_in?
	# end
	#
	# def authorize_with_token!(key)
	# 	render json: { "errors" => "Not authorized, user_id: #{params[key]}, key var: #{key}" },
	# 									 status: :unauthorized unless same_user_signed_in?(key)
	# end
	#
	# def user_signed_in?
	# 	current_user.present?
	# end
	#
	# def same_user_signed_in?(key)
	# 	user_signed_in? && current_user.id == params[key].to_i
	# end
	#
end
