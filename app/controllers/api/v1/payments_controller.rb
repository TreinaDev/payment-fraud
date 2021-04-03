module Api
  module V1
    class PaymentsController < ApiController
      # POST /api/v1/payments
      def create
        payment = Payment.new(payment_params)

        if payment.save
          render status: :created, json: payment
        else
          render status: :unprocessable_entity,
                 json: { errors: payment.errors.full_messages }
        end
      end

      # GET /api/v1/payments/:token
      def show
        payment = Payment.find_by(payment_token: params[:token])

        if payment.nil?
          return render status: :not_found,
                        json: { message: 'não encontrado' }
        end

        payment.change_status
        render json: payment.as_json(only: %i[status customer_token payment_token cpf plan_price discount_price])
                            .merge({ 'payment_method' => payment.payment_method.code })
      end

      # GET /api/v1/payments/customer_payments/:customer_token
      def list_payments
        payments = Payment.where(customer_token: params[:customer_token])

        render json: payments.as_json(except: %i[created_at updated_at])
      end

      private

      def payment_params
        params.require(:payment).permit(:payment_method_id, :cpf,
                                        :customer_token, :plan_id,
                                        :plan_price, :discount_price)
      end
    end
  end
end
