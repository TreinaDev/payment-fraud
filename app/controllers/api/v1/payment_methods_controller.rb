class Api::V1::PaymentMethodsController < Api::V1::ApiController
  def index
    payment_methods = PaymentMethod.all
    render json: payment_methods
  end
  # rescue ActiveRecord::ActiveRecordError
  #   render json: { status: }

  # Mock rspec do active record error

end