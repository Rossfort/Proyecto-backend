class Api::AdminsController < ApplicationController
  before_action :authorized

  def current
    render json: current_user
  end
end
