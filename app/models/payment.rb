class Payment < ApplicationRecord
  belongs_to :payment_method

  validates :customer_token, :cpf,
            :plan_id, :payment_token, presence: true
  validates :payment_token, uniqueness: { message: 'token deve ser único' }


  def generate_token
    SecureRandom.hex
  end
end
