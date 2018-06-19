class AuthenticateOmniauthUser
  prepend SimpleCommand

  def initialize(auth_hash)
    @auth_hash = auth_hash
  end

  def call
    user
  end

  private

  attr_accessor :auth_hash

  def user
    user = User.from_omniauth(auth_hash)
    return user if user

    errors.add :user_omniauth_authentication, 'Invalid Authorization from Provider!'
    nil
  end
end
