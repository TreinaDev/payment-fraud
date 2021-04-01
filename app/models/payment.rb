class Payment < ApplicationRecord
  # TODO: Validar Payment Method status active para criar payment (tentar before_save)
  belongs_to :payment_method

  has_secure_token :payment_token

  enum status: { pending: 0, approved: 5, refused: 10 }

  validates :customer_token, :cpf,
            :plan_id, presence: true
  validates :payment_token, uniqueness: { message: :unique }
  validates :plan_price, presence: true, numericality: { greater_than: 0 }
  validate :payment_method_status?, on: :create

  def change_status
    return false unless pending?

    success_rate = Random.rand
    if success_rate <= 0.2
      refused!
    else
      approved!
    end
  end

  def payment_method_status?
    return unless payment_method.inactive?

    errors.add(:payment, 'O meio de pagamento não pode estar inativo')
  end
end
