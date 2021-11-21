class Api::ContactsController < ApplicationController
  def create
    ContactsMailer.with(
      email: params[:email],
      name: params[:name],
      phone: params[:phone],
      message: params[:message]
    ).contact_mail.deliver_now
  end
end
