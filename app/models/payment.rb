class Payment < ApplicationRecord
  belongs_to :payment_method

  has_secure_token :payment_token

  validates :customer_token, :cpf,
            :plan_id, :plan_price, presence: true
  validates :payment_token, uniqueness: { message: :unique }

  enum status: { pending: 0, approved: 5, refused: 10 }
end
