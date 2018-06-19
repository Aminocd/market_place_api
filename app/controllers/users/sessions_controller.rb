class Users::SessionsController < Devise::SessionsController
  include AuthenticationHelper
  respond_to :json
  prepend_before_action :require_no_authentication, only: [:create]
  prepend_before_action :configure_sign_in_params, only: [:create]

 private

 def respond_with(resource, _opts = {})
   render_resource_or_jwt(resource, set_jwt(request.env['warden-jwt_auth.token']))
 end

 def ensure_params_exist
    return unless params[:user].blank?
    missing_param_error("missing sign_in parameter")
 end

 def configure_sign_in_params
   ensure_params_exist
   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
 end

 def respond_to_on_destroy
   head :no_content
 end
end
