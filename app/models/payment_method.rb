class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  enum status: { inactive: 0, active: 3 }
  validates :name, :max_installments, :code, :status, presence: true
end