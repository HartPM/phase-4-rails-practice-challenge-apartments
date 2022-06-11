class TenantSerializer < ActiveModel::Serializer
  attributes :name, :age

  has_many :leases
  has_many :apartments
end
