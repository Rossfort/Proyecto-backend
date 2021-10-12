class Api::Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authorized

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    render json: @category, status: :ok
  end

  def edit
    @encoded_image = image_to_base64(@category.image)
    respond_to do |format|
      format.json
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: 'algo salio mal', status: :bad_request
    end
  end

  def destroy
    @category.destroy
    render json: 'categoria borrada', status: :no_content
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category, status: :created
    else
      render json: 'Algo salio mal', status: :bad_request
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end
end
