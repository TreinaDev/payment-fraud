class Payment < ApplicationRecord
  belongs_to :payment_method

  has_secure_token :payment_token

  validates :customer_token, :cpf,
            :plan_id, presence: true
  validates :payment_token, uniqueness: { message: :unique }
  validates :plan_price, presence: true, numericality: { greater_than: 0 }

  enum status: { pending: 0, approved: 5, refused: 10 }
end
