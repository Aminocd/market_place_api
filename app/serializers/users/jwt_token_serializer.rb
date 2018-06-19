class Users::JwtTokenSerializer < ActiveModel::Serializer
  attributes :id, :jwt, :auth_type
  def auth_type
    "Bearer"
  end
end
