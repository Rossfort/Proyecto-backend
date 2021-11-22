class ContactsMailer < ApplicationMailer
  default from: "seba@gmail.com"

  def contact_mail
    @email = params[:email]
    @name = params[:name]
    @phone = params[:phone]
    @message = params[:phone]
    mail(to: 'thexbax@gmail.com', subject: 'Contacto 4mods')
  end
end
