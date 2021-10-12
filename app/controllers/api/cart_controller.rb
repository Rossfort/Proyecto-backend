class Api::CartController < ApplicationController
  def index
  end

  def test
    redirect_to 'http://localhost:3000/products'
  end
end
