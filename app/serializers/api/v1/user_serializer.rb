class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :email, :created_at, :updated_at, :verified_email

  has_many :products

  def verified_email
    object.verified_email?
  end
end
