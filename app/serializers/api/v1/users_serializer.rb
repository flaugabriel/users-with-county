class Api::V1::UsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :cns, :email, :birth_date, :phone, :status

  def id
    object.id || 0
  end

  def name
    object.name || ''
  end

  def cpf
    object.cpf || ''
  end

  def cns
    object.cns || ''
  end

  def email
    object.name || ''
  end

  def birth_date
    object.birth_date || ''
  end

  def phone
    object.phone || ''
  end

  def status
    object.status || 0
  end
end
