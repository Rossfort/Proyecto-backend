class Api::ProductsController < ApplicationController
  def index
    @products = Product.kept.includes(:variants).offset(params[:offset].to_i).limit(12)
    @total_pages = (Product.kept.count / 12.0).ceil
  end

  def show
    @product = Product.find(params[:id])
  end
end
