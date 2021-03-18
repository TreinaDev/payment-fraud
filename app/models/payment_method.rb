class PaymentMethod < ApplicationRecord
  has_one_attached :icon
  validates :name, :max_installments, :code, presence: true
end