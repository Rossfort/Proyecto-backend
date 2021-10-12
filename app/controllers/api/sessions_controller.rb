class Api::SessionsController < ApplicationController
  def create
    @admin = Admin.find_by(email: session_params[:email])

    if @admin && @admin&.authenticate(session_params[:password])
      login!
      render json: {
        logged_in: true,
        user: @admin
      }
    else
      render json: {
        status: 401,
        errors: ['Usuario invalido, intentalo de nuevo']
      }
    end
  end

  def destroy
    logout!
    render json: {
      status: 200,
      logged_out: true
    }
  end

  private

  def session_params
    params.require(:admin).permit(:email, :password)
  end
end
