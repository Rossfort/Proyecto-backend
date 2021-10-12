class Api::Admin::OrdersController < ApplicationController
  before_action :authorized
  before_action :set_order, only: %i[show update]

  def index
    @orders = Order.all
    @statuses = Order.statuses.keys
    @orders = filter(@orders)
    @pages = (@orders.count / 10.0).ceil
    @orders = @orders.offset(params[:offset]) if params[:offset].present?
    @orders = @orders.limit(10)
  end

  def show; end

  def update
    @order.update(order_params)
    render json: @order
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end

  def filter(orders)
    orders = orders.filter_by_id(params[:order_id]) if params[:order_id].present?
    orders = orders.filter_by_email(params[:email]) if params[:email].present?
    orders = orders.filter_by_status(params[:status]) if params[:status].present?
    orders
  end
end
