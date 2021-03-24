class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  validates :name, :max_installments, :code, :status, presence: true
  enum status: { inactive: 0, active: 3 }
end
