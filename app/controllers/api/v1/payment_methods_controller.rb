class Api::V1::PaymentMethodsController < Api::V1::ApiController
  def index
    payment_methods = PaymentMethod.where(status: :active)
    render json: payment_methods
                 .as_json(include: { icon: {
                                        include: { blob: {
                                            only: [:id, :key, :filename]
                                          }
                                        }, except: [:created_at]
                                      }
                                    })
  end
end