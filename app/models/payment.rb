class Payment < ApplicationRecord
  belongs_to :payment_method

  validates :customer_token, :cpf,
            :plan_id, :payment_token, presence: true
  validates :payment_token, uniqueness: { message: :unique }

  before_validation :generate_token

  private

  def generate_token
    token = SecureRandom.hex

    if Payment.find_by(payment_token: token).nil?
      self.payment_token = token
    else
      self.payment_token = SecureRandom.hex
    end
  end
end
