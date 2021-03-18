module Api
  module V1
    class PaymentsController < ApiController
      # POST /api/v1/payments
      def create
        payment = Payment.new(payment_params)

        if payment.save
          render status: '201', json: payment
        else
          render status: '422', json: { message: 'parâmetros inválidos' }
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

      private

      def payment_params
        params.require(:payment).permit(:payment_method_id, :cpf, :customer_token, :plan_id)
      end
    end
  end
end
