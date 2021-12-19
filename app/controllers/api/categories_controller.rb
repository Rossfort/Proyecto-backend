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
      @products = order_products(@products, params[:order])
      @products = @products.where('variants.stock > 0')
      @total_pages = (@products.length / 12.0).ceil
    else
      @products = @category.products.kept
      @products = order_products(@products, params[:order])
    @products = @products.where('variants.stock > 0')
      @total_pages = (@products.count / 12.0).ceil
    end
    @products = @products.limit(12).offset(offset)
    @products = @products.uniq
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
    category.products.joins(variants: :product_properties).where(product_properties: { id: p }).kept.group(:id,
                                                                                                           'variants.price')
  end

  def order_products(products, order_type)
    p = products
    case order_type
    when '3'
      p = products.joins(:variants).order(visit_count: :desc)
    when '2'
      p = products.joins(:variants).order('variants.price DESC')
    when '1'
      p = products.joins(:variants).order('variants.price ASC')
    end
    p
  end
end
