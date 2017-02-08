class ProductSerializer < ActiveModel::Serializer
  attributes :title, :price, :published
  has_one :user #, include: :email

end
