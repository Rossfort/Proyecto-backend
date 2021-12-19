class AfterTransactionMailer < ApplicationMailer
  default from: ENV['GMAIL_USER']

  def order_placed
    @email = params[:email]
    @order = params[:order]
    mail(to: @email, subject: 'Contacto 4mods')
  end

  def order_shipped
    @email = params[:email]
    @order = params[:order]
    mail(to: @email, subject: 'Contacto 4mods')
  end

  def order_payed
    @email = params[:email]
    @order = params[:order]
    mail(to: @email, subject: 'Contacto 4mods')
  end
end
