class ContactsMailer < ApplicationMailer
  default from: ENV['GMAIL_USER']

  def contact_mail
    @email = params[:email]
    @name = params[:name]
    @phone = params[:phone]
    @message = params[:phone]
    mail(to: 'thexbax@gmail.com', subject: 'Contacto 4mods')
  end
end
