class Payment < ApplicationRecord
  belongs_to :payment_method

  has_secure_token :payment_token

  enum status: { pending: 0, approved: 5, refused: 10 }

  validates :customer_token, :cpf,
            :plan_id, presence: true
  validates :payment_token, uniqueness: { message: :unique }

  def change_status
    return false unless self.pending?

    success_rate = rand(1..10)
    puts "success #{success_rate}"
    if success_rate <= 2
      self.refused!
    else
      self.approved!
    end
  end
end
