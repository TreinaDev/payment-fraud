class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment

  def valid_token
    token = rand 1000000000..9999999999
    #TODO validar se token existe Receipt.where(token_receipt: token).exists?
    token_receipt = token
  end
end

