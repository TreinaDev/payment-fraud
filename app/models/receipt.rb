class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment

  def valid_token
    token = rand 1_000_000_000..9_999_999_999
    # TODO: validar se token existe Receipt.where(token_receipt: token).exists?
    self.token_receipt = token
  end
end
