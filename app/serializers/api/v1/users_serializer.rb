class Api::V1::UsersSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :cpf, :cns, :email, :birth_date, :phone, :status, :avatar_url

  def avatar_url
    object.avatar.attached? ? rails_blob_url(object.avatar) : ''
  end

  def id
    object.id || 0
  end

  def name
    object.name || ''
  end

  def cpf
    object.cpf || '00000000000'
  end

  def cns
    object.cns || ''
  end

  def email
    object.name || ''
  end

  def birth_date
    object.birth_date.strftime('%d/%m/%Y') || ''
  end

  def phone
    object.phone || ''
  end

  def status
    object.status || 0
  end
end
