class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_omniauth_user, :only => [:facebook, :google_oauth2]
  respond_to :json
  include AuthenticationHelper
  def all
    if @user.persisted?
      sign_in('user', @user)
      render_resource_or_jwt(@user, set_jwt(request.env['warden-jwt_auth.token']))
    else
      session["devise.provider_data"] = auth_hash
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all

  private
  def auth_hash
    request.env["omniauth.auth"]
  end

  def set_omniauth_user
    auth_command = AuthenticateOmniauthUser.call(auth_hash)
    if auth_command.success?
      @user = auth_command.result
    else
      validation_error(auth_command)
    end
  end
end
