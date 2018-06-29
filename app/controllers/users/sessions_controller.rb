class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, if: -> {request.format.json?}
  def create
    resource = warden.authenticate!(:scope => :user)
    unless resource.errors.any?
      sign_in(:user, resource, bypass: true)
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
