class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment

  def self.valid_token
    loop do
      token = rand 1_000_000_000..9_999_999_999
      break token unless Receipt.exists?(token_receipt: token)
    end
  end
end
