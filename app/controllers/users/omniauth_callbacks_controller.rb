class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, if: -> {request.format.json?}
  before_action :set_omniauth_user, :only => [:facebook, :google_oauth2]
  def all
    if @user.persisted?
      sign_in('user', @user)
      jwt = set_jwt(request.env['warden-jwt_auth.token'])
      data = Users::JwtTokenSerializer.new(jwt).to_json
      redirect_to user_session_url(protocol: 'mycurrency', data: data)
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
