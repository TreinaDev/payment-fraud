class Payment < ApplicationRecord
  belongs_to :payment_method
  has_one :receipt, dependent: :delete

  has_secure_token :payment_token

  enum status: { pending: 0, approved: 5, refused: 10 }

  validates :customer_token, :cpf,
            :plan_id, presence: true
  validates :payment_token, uniqueness: { message: :unique }
  validates :plan_price, presence: true, numericality: { greater_than: 0 }

  def change_status
    return false unless pending?

    success_rate = Random.rand
    if success_rate <= 0.2
      refused!
    else
      approved!
    end
    generate_receipt
  end

  def generate_receipt
    Receipt.create!(token_receipt: (rand 1_000_000_000..9_999_999_999).to_s,
                    number_installment: 1,
                    payment_id: id)
  end
end
