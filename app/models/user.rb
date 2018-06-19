class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Devise::JWT::RevocationStrategies::Whitelist
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :jwt_authenticatable, :omniauthable, :jwt_revocation_strategy => self, :omniauth_providers => [:facebook, :google_oauth2]

  validates :email, uniqueness: true
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
    where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = Rails.env.production? ? auth.info.email : (auth.info.email.present?  ? auth.info.email  : FFaker::Internet.email) # Ben 6/17/2018 Facebook does Not allow you to retreive emails of users until the FB App is live. Change this line later once you have the app up and running
      user.password = Devise.friendly_token[0,20]
      user.password_confirmation = user.password
      user.save!
    end
  end
end
