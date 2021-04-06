require 'rails_helper'

describe Receipt do
  context 'create' do
    it 'successfully when payment change status' do
      payment_method = create(:payment_method, status: 'active')
      payment = create(:payment, payment_method: payment_method)

      payment.change_status

      expect(Receipt.all.size).to eq 1
    end

    it 'cannot have blank attributes' do
      receipt = Receipt.new

      expect(receipt.valid?).to be_falsy
      expect(receipt.errors.count).to eq(3)
    end

    it 'token_receipt must be uniq' do
      payment_method = create(:payment_method, status: 'active')
      payment = create(:payment, payment_method: payment_method)
      payment2 = create(:payment, payment_method: payment_method)
      Receipt.create!(token_receipt: '1A2A3B456C789', number_installment: 1,
                      payment_id: payment.id)
      receipt = Receipt.new(token_receipt: '1A2A3B456C789', number_installment: 10,
                            payment_id: payment2.id)

      expect(receipt.valid?).to eq false
      expect(receipt.errors[:token_receipt]).to include('já está em uso')
    end
  end
end
