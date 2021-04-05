require 'securerandom'

class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment

  def self.valid_token
    loop do
      token = SecureRandom.hex(10)
      token = token.upcase
      break token unless Receipt.exists?(token_receipt: token)
    end
  end
end
