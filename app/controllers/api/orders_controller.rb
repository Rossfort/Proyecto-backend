module Api
  class OrdersController < ApplicationController
    before_action :set_user, only: [:create]
    def create
      order = @user.orders.new(order_params)

      process_cart(order)

      case order.pay_method
      when PaymentMethods::TRANSFER
        transfer(order)
      when PaymentMethods::WEBPAY
        webpay(order)
      end
    end

    private

    def transfer(order)
      if order.save
        render json: { order: order, type: 'transfer' }, status: :created
      else
        render json: { message: 'hubo un error al crear la order, por favor intentar mas tarde' },
               status: :unprocessable_entity
      end
    end

    def webpay(order)
      order.save
      response = webpay_response(order.id, order.amount)
      order.token = response.token
      if order.save
        render json: { res: response, order: order, type: 'webpay' }, status: :ok
      else
        render json: { message: 'hubo un error al crear la order por favor intentar mas tarde' },
               status: :unprocessable_entity
      end
    end

    def order_params
      params.require(:order).permit(:name, :last_name, :address, :city, :comuna, :phone, :pay_method, :shipping_method)
    end

    def webpay_response(id, total)
      Transbank::Webpay::WebpayPlus::Transaction.create(
        buy_order: id,
        session_id: 'noop',
        amount: total,
        return_url: 'http://localhost:2000/api/payment'
      )
    end

    def set_user
      @user ||= User.find_or_create_by(email: params[:email])
    end

    def cart_params
      params.require(:cart)
    end

    def process_cart(order)
      total = 0
      cart_params.each do |variant, quantity|
        line_item = order.line_items.new(quantity: quantity.to_i, variant_id: variant.to_i)
        process_stock(line_item, quantity.to_i)
        total += line_item.variant.price * line_item.quantity
      end
      order.amount = total
    end

    def process_stock(line_item, quantity)
      if quantity <= line_item.variant.stock
        line_item.variant.update(stock: 0)
      else
        line_item.variant.update(stock: line_item.variant.stock - quantity)
      end
    end
  end
end
