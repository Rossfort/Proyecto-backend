class Api::Admin::VariantsController < ApplicationController
  before_action :authorized

  def index
    variants = Product.find(params[:product_id]).variants.order(size: :asc)
    render json: variants, status: :ok
  end

  def create
    variant = Product.find(params[:product_id]).variants.new(variant_params)
    variant.is_master = true unless variant.product.master
    if variant.save
      render json: variant, status: :created
    else
      render json: variant.errors, status: :bad_request
    end
  end

  def edit
    variant = Variant.find(params[:id])

    if variant
      render json: variant, status: :ok
    else
      render json: { message: 'Variante no encontrada' }, status: :not_found
    end
  end

  def update
    variant = Variant.find(params[:id])
    variant.update(variant_params)
    render json: variant, status: :accepted
  end

  def destroy
    variant = Variant.find(params[:id])
    variant.discard
    render json: :no_content
  end

  def restore
    variant = Variant.find(params[:variant_id])
    if variant.undiscard
      render json: variant, status: :ok
    else
      render json: { message: 'Variante no pudo ser recuperada' }, status: :method_not_allowed
    end
  end

  private

  def variant_params
    params.require(:variant).permit(:price, :size, :stock)
  end
end
