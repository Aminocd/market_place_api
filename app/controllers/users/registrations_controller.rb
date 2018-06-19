class Users::RegistrationsController < Devise::RegistrationsController
  include AuthenticationHelper
  respond_to :json
  prepend_before_action :require_no_authentication, only: [:create]
  before_action :configure_sign_up_params, only: [:create]


  def create
    build_resource(sign_up_params)
    if resource.save
      sign_in(resource_name, resource)
      render_resource_or_jwt(resource, set_jwt(request.env['warden-jwt_auth.token']))
    else
      clean_up_passwords resource
      validation_error(resource)
    end
  end

  private
  def ensure_params_exist
     return unless params[:user].blank?
     missing_param_error("missing sign_up parameter")
  end

  def configure_sign_up_params
    ensure_params_exist
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end
end
