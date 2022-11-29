class UserMailer < ApplicationMailer
  default from: 'flaugabriel@gmail.com'

  def profile_updated(user_object)
    mail to: 'user@gmail.com', subject: 'Seu perfil foi atualizado'
    mail(
      to: user_object.email,
      subject: 'Seu perfil foi atualizado no OM30-flauzino'
    )
  end
end
