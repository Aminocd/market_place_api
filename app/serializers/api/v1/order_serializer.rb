class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at, :total

  belongs_to :user
  has_many :placements
  has_many :products #, serializer: OrderProductSerializer
end
