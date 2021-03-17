class Api::V1::PaymentMethodsController < Api::V1::ApiController
  def index
    @payment_methods = PaymentMethod.all
    render json: @payment_methods
  end

  def create
    payment_method = PaymentMethod.new(payment_method_params)

    if payment_method.save
      render json: payment_method
    end
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :code, :max_installments, :icon)
  end
end