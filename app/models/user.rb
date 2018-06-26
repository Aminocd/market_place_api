class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Devise::JWT::RevocationStrategies::Whitelist
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :jwt_authenticatable, :omniauthable, :jwt_revocation_strategy => self, :omniauth_providers => [:facebook, :google_oauth2]

  validates :email, uniqueness: true
  validates :uid, uniqueness: { scope: :provider }, if: :omniauth_user? #Added this validation to make unique constraints more readable to the end user instead of a long datbase error.

  #Ben 6/17/2018 I removed the auth token column in favor of the whitelisted_jwt strategy in the devise-jwt gem.  This allows users to login with multiple devices and uses JWTs which are mobile friendly
  # validates :auth_token, uniqueness: true

  # def generate_authentication_token!
	# begin
	#   self.auth_token = Devise.friendly_token
	# end while self.class.exists?(auth_token: auth_token)
  # end
  #
  # before_create :generate_authentication_token!


  has_many :products, inverse_of: :user, dependent: :destroy
  has_many :orders, inverse_of: :user, dependent: :destroy
  #Ben 6/17/2018 The two methods below are required for omniauth to work
  def self.new_with_session(params, session)
   super.tap do |user|
     if data = session["devise.provider_data"] && session["devise.provider_data"]["extra"]["raw_info"]
       user.email = data["email"] if user.email.blank?
     end
   end
 end

 def self.from_omniauth(auth)
   email = auth.info.email || temp_email(auth.provider, auth.uid)
    u = where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = email if user.email.blank? #Ben 6/25/2018 this prevents the email from being set again as the email will only be blank on create. Note that if no email is present in the auth hash on create it will create a temporary one. but you can allow the user to change it on the front end. I made a helper method called verfied email that resturns true or false. This will allow you to prevent emails from being sent out if the users havent changed the temp email that was set. I also exposed it in the json object so you can use it to control states on the front end.
      user.password = Devise.friendly_token[0,20] if user.encrypted_password.blank?
      user.password_confirmation = user.password if user.encrypted_password.blank?
    end
    u.save
    u
  end

  def omniauth_user?
    self.provider.present? && self.uid.present?
  end

  #Ben 6/25/2018 Add logic to mailers not to send order confirmations unless the user has a verfied email also check if this field is in the json object to handle logic on the front end
  def verified_email?
    omniauth_user? && self.email != temp_email(self.uid, self.provider)
  end

  protected
  def self.temp_email(uid, provider)
    "temp-#{uid}@#{provider}.com"
  end
end
