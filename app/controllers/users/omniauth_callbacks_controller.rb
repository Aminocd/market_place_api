class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  before_action :set_omniauth_user, only: %i[facebook google_oauth2]
  before_action :set_facebook_user, only: %i[facebook_token]

  def all
#    Rails.logger.error @user
    if @user.persisted?
      sign_in('user', @user)
      jwt = set_jwt(request.env['warden-jwt_auth.token'])
#      Rails.logger.info request.env['warden-jwt_auth.token']
#      Rails.logger.info @user
#      Rails.logger.info jwt
      if params[:json]
        render_resource_or_jwt(@user, jwt)
      else # TODO: remove after deploy server and client app
        data = Users::JwtTokenSerializer.new(jwt).to_json
        redirect_to user_session_url(protocol: app_protocol, data: data)
      end
    else
      session['devise.provider_data'] = auth_hash
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  alias_method :facebook_token, :all

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def set_omniauth_user
#    Rails.logger.error "DEBUGGING"
#    Rails.logger.error auth_hash
    set_user auth_hash
  end

  def set_user(auth_hash)
    auth_command = AuthenticateOmniauthUser.call(auth_hash)
    if auth_command.success?
      @user = auth_command.result
    else
      if params[:json]
        validation_error auth_command
      else # TODO: remove after deploy server and client app
        redirect_to user_session_url(protocol: app_protocol, errors: auth_command.errors.to_json)
      end
    end
  end

  def set_facebook_user
    facebook = Koala::Facebook::API.new params[:token]
    profile = facebook.get_object :me, fields: :email
    auth_hash = Hashie::Mash.new provider: :facebook, uid: profile['id'], info: { email: profile['email'] }
    set_user auth_hash
  end

  # TODO: move to config
  def app_protocol
    'mycurrency'
  end
end
