class Api::V1::PaymentMethodsController < Api::V1::ApiController
  def index
    payment_methods = PaymentMethod.where(status: :active)
    render json: payment_methods, status: 200
  end
end