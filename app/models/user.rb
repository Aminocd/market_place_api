class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  validates :email, uniqueness: true
#  validates :auth_token, uniqueness: true

=begin  def generate_authentication_token!
	begin
	  self.auth_token = Devise.friendly_token
	end while self.class.exists?(auth_token: auth_token)
=end  end

#  before_create :generate_authentication_token!
 
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
end
