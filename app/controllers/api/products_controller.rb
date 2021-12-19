class Api::ProductsController < ApplicationController
  def index
    @products = Product.kept.includes(:variants).offset(params[:offset].to_i).limit(12)
    @products = Product.kept.order(created_at: :desc).limit(4) if params[:last].present?
    @total_pages = (Product.kept.count / 12.0).ceil
  end

  def show
    @product = Product.find(params[:id])
  end

  def visit
    @product = Product.find(params[:id])
    @product.visit_count += 1
    @product.save
  end

  def search
    query = params[:search].split('=')[1]
    @products = Product.kept.where('LOWER(title) like ?', "%#{query.downcase}%")
    @total_pages = (@products.kept.count / 12.0).ceil
  end
end
