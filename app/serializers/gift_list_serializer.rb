class GiftListSerializer < ActiveModel::Serializer
  # attributes to be serialized  
  attributes :id, :title, :text
  # model association
  has_many :gifts
end
