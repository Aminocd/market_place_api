class Users::SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => :user)
    unless resource.errors.any?
      sign_in(resource_name, resource)
      render_resource_or_jwt(resource, set_jwt(request.env['warden-jwt_auth.token']))
    else
      validation_error(resource)
    end
  end

  def destroy
    super
  end
  private
  #Controller Specific Overrides
  def respond_to_on_destroy
    render json: {success: true, message: "Successfully Logged Out"}, status: :no_content
  end
end
