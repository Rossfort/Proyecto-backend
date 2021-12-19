module Api
  class PaymentsController < ApplicationController
    before_action :set_order

    def commit
      if tbk_token.present?
        @order.cancelado!
        redirect_to "http://localhost:3000/transactions/#{@order.uuid}"
        return
      end

      res = Transbank::Webpay::WebpayPlus::Transaction.commit(token: token_ws)

      @order.create_payment(payload: res)
      @order.pagado! if res.status == 'AUTHORIZED'
      redirect_to "http://localhost:3000/transactions/#{@order.uuid}"
    end

    def show; end

    private

    def set_order
      set_order_by_uuid and return if params[:uuid]

      set_order_by_token
    end

    def set_order_by_uuid
      @order ||= Order.find_by(uuid: params[:uuid])
    end

    def set_order_by_token
      @order ||= Order.from_token(tbk_token) and return if tbk_token
      @order ||= Order.from_token(token_ws) and return if token_ws
    end

    def token_ws
      params[:token_ws]
    end

    def tbk_token
      params[:TBK_TOKEN]
    end
  end
end
