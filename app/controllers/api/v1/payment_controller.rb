module Api
  module V1
    class PaymentController < ApiController
      def create
        payment = Payment.new(payment_params)
        payment.payment_token = payment.generate_token

        render json: payment if payment.save
      end

      private

      def payment_params
        params.require(:payment).permit(:payment_method_id, :cpf, :customer_token, :plan_id)
      end
    end
  end
end