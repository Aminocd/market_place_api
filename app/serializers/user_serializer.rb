class UserSerializer < ActiveModel::Serializer
  attributes :email, :created_at, :updated_at, :auth_token

  has_many :products
end
