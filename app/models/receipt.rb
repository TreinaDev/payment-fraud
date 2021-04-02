class Receipt < ApplicationRecord
  validates :token_receipt, :number_installment, presence: true
  validates :token_receipt, uniqueness: true
  belongs_to :payment

  validate :valid_token

  def valid_token
    loop do
      token = rand 1_000_000_000..9_999_999_999
      validate_uniq = Receipt.where(token_receipt: token)
      if validate_uniq.blank?  
        byebug
        self.token_receipt = token
        break
      end
    end
    self.save
    # TODO: validar se token existe Receipt.where(token_receipt: token).exists?
  end
end
