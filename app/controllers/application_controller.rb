class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  helper_method :login!, :logged_in?, :current_user, :authorized_user?, :logout!, :set_user, :image_to_base64

  def image_to_base64(image)
    image.open do |img|
      "data:image/png;base64,#{Base64.strict_encode64(img.read)}"
    end
  end

  def login!
    session[:admin] = @admin
  end

  def logged_in?
    !!session[:admin]
  end

  def current_user
    @current_user ||= Admin.find(session[:admin]['id']) if session[:admin]
  end

  def authorized_user?
    @admin == current_user
  end

  def logout!
    session.clear
  end

  def set_user
    @admin = Admin.find_by(id: session[:admin].id)
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
