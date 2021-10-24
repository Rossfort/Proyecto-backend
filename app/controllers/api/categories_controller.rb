class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    offset = params[:offset].to_i
    name = params[:name].include?('_') ? params[:name].gsub!('_', ' ') : params[:name]
    @category = Category.find_by("lower(name) = '#{name.downcase}'")
    if params[:properties].present?
      @products = filter(params[:properties], @category)
      @products = @products.limit(12).offset(offset)
    else
      @products = @category.products.kept.limit(12).offset(offset)
    end
    @total_pages = (@products.length / 12.0).ceil
  end

  def category_properties
    name = params[:name].include?('_') ? params[:name].gsub!('_', ' ') : params[:name]
    @category = Category.find_by("lower(name) = '#{name.downcase}'")
  end

  private

  def filter(query_string, category)
    product_properties = []
    query_string.each do |_key, val|
      product_properties.push(val)
    end
    p = product_properties.flatten
    category.products.joins(variants: :product_properties).where(product_properties: { id: p }).kept.group(:id)
  end
end
