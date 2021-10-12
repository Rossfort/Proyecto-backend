class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    offset = params[:offset].to_i
    name = params[:name].include?('_') ? params[:name].gsub!('_', ' ') : params[:name]
    @category = Category.find_by("lower(name) = '#{name.downcase}'")
    @products = @category.products.limit(12).offset(offset)
    @total_pages = (@category.products.kept.count / 12.0).ceil
  end

  def category_properties
    name = params[:name].include?('_') ? params[:name].gsub!('_', ' ') : params[:name]
    @category = Category.find_by("lower(name) = '#{name.downcase}'")
  end
end
