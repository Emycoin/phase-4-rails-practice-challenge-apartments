class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :rent
  has_one :tenant
  has_one :apartment
  
end
