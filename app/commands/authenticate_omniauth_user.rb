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
    if user.present?
      errors.add :user_omniauth_authentication, user.errors.full_messages.join(" ") if user.errors.any?
      return user
    end

    errors.add :user_omniauth_authentication, 'Invalid Authorization from Provider!'
    nil
  end
end
