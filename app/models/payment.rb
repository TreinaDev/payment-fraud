class Payment < ApplicationRecord
  belongs_to :payment_method

  has_secure_token :payment_token

  enum status: { pending: 0, approved: 5, refused: 10 }

  validates :customer_token, :cpf,
            :plan_id, presence: true
  validates :payment_token, uniqueness: { message: :unique }

  def change_status
    return false unless pending?

    success_rate = Random.rand
    if success_rate <= 0.2
      refused!
    else
      approved!
    end
  end
end
