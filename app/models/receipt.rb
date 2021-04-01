class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment
end
