module Api
  module V1
    class PaymentsController < ApiController
      # POST /api/v1/payments
      def create
        payment = Payment.new(payment_params)

        if payment.save
          render status: :created, json: payment
        else
          render status: :unprocessable_entity, json: { errors: payment.errors.full_messages }
        end
      end

      # GET /api/v1/payments/:id
      def show
        payment = Payment.find_by(params[:id])

        if payment.nil?
          return render status: :not_found,
                        json: { message: 'não encontrado' }
        end

        render json: payment, status: :ok
      end

      def update
        payment = Payment.find_by(customer_token: params[:customer_token])

        if payment.update(payment_params)
          render json: payment, status: :ok
        else
          render json: { message: 'erro no pagamento'}, status: :request_timeout 
        end
      end

      private

      def payment_params
        params.require(:payment).permit(:payment_method_id, :cpf, :customer_token, :plan_id, :status)
      end
    end
  end
end
