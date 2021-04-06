module Api
  module V1
    class PaymentMethodsController < ApiController
      def index
        payment_methods = PaymentMethod.where(status: :active)
        render json: payment_methods.as_json(only: %i[id name max_installments code], include:
          { icon: { include: { blob:
            {
              only: %i[id key filename]
            } }, only: :id } })
      end
    end
  end
end
