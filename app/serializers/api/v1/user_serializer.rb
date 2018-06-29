class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :email, :created_at, :updated_at

  has_many :products
end
