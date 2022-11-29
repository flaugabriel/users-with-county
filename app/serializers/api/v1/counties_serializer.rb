class Api::V1::CountiesSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :user_count, :address_count

  def id
    object.id || 0
  end

  def name
    object.name || ''
  end

  def status
    object.status || false
  end

  def address_count
    object.addresses.length || 0
  end

  def user_count
    object.user_counties.map(&:user).length || 0
  end
end
