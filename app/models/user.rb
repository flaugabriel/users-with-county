class User < ApplicationRecord
  has_one_attached :avatar

  enum status: %w[off on]
  has_one :user_county

  validates_uniqueness_of :name, only: :create
  validates_presence_of :name, :cpf, :cns, :email, :birth_date, :phone
  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validate :cpf_valid, :validate_age, :avatar_file

  after_update :send_notify_email

  def avatar_url
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def self.sort_by
    %w[name email]
  end

  private

  def send_notify_email
    UserMailer.profile_updated(self).deliver_now!
  end

  def avatar_file
    return unless avatar.present?

    return avatar.blob.content_type.include?('jpeg') || avatar.blob.content_type.include?('png')

    errors.add(:base, 'Formato não foto não aceito!')
  end

  def cpf_valid
    return if CPF.valid?(cpf)

    errors.add(:base, 'CPF invalido!')
  end

  def validate_age
    db = birth_date + 18.years
    return if  db <= DateTime.now

    errors.add(:data_de_aniversario, 'precisa ser a maior ou igual a 18 anos')
  end

  private_class_method :sort_by
end
