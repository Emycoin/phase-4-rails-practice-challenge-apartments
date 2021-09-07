class TenantSerializer < ActiveModel::Serializer
  attributes :id, :name, :age
  has_many :apartments 
  has_many :leases 
end
