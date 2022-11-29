class Api::V1::AddressSerializer < ActiveModel::Serializer
  attributes :id, :cep, :complement, :street, :neighborhood, :city, :uf, :ibge_code, :county_name

  def id
    object.id || 0
  end

  def cep
    object.cep.to_s || 0
  end

  def complement
    object.complement || ''
  end

  def street
    object.street || ''
  end

  def neighborhood
    object.neighborhood || ''
  end

  def city
    object.city || ''
  end

  def uf
    object.uf || ''
  end

  def ibge_code
    object.ibge_code || ''
  end

  def county_name
    object.county.name
  end
end
