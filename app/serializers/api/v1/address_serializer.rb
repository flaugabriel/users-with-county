class Api::V1::AddressSerializer < ActiveModel::Serializer
  attributes :cep, :complement, :street, :neighborhood, :city, :uf, :ibge_code

  def cep
    object.cep || 0
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
end
