class Api::V1::CountiesAndUsersSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :cns, :email, :birth_date, :phone, :status

  def id
    object.user.id || 0
  end

  def name
    object.user.name || ''
  end

  def cpf
    object.user.cpf || ''
  end

  def cns
    object.user.cns || ''
  end

  def email
    object.user.email || ''
  end

  def birth_date
    object.user.birth_date || ''
  end

  def phone
    object.user.phone || ''
  end

  def status
    object.user.status || 0
  end
end
