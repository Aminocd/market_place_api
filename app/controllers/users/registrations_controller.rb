class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, if: -> {request.format.json?}
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
end
