class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_changed.subject
  #
  default from: "no-responder@grauercatering.com"

  def password_changed(id)
    @user = User.find(id)
    mail to: @user.email, subject: "Su contraseña de Grauer Catering ha sido modificada"
  end  
end
