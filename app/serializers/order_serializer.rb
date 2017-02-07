class OrderSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at, :total

  belongs_to :user
  has_many :placements
end
