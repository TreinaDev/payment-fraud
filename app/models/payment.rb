class Payment < ApplicationRecord
  belongs_to :payment_method

  validates :customer_token, :cpf,
            :plan_id, :payment_token, presence: true
  validates :payment_token, uniqueness: { message: 'token deve ser único' }

  before_validation :generate_token

  private
  
  def generate_token
    self.payment_token = SecureRandom.hex
  end
end
