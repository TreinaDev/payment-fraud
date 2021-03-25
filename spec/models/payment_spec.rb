require 'rails_helper'

describe Payment do
  context 'create new payment' do
    it 'successfully with all params' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method: payment_method, customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12', plan_id: '1')

      expect(Payment.all.size).to eq 1
      expect(Payment.last.payment_token).to eq payment.payment_token
    end

    it 'can not have blank attributes' do
      payment = Payment.new

      expect(payment.valid?).to be_falsy
      expect(payment.errors.count).to eq(4)
    end

    it 'payment token must be uniq' do
      payment_method = FactoryBot.create(:payment_method)
      payment_first = Payment.create!(payment_method: payment_method,
                                      customer_token: 'a1s2d3f4',
                                      payment_token: '1a2s3d4f5g6h7j',
                                      cpf: '123.123.123-12', plan_id: '1')

      payment_invalid = Payment.new(payment_method: payment_method,
                                    customer_token: 'a1s2d3f4',
                                    payment_token: '1a2s3d4f5g6h7j',
                                    cpf: '123.123.123-12', plan_id: '1')

      expect(payment_invalid.payment_token).to eq(payment_first.payment_token)
      expect(payment_invalid.valid?).to eq false
      expect(payment_invalid.errors[:payment_token]).to include('Token deve ser único')
    end
  end

  context '.change_status' do
    it 'status should be approved if random bigger or equal than 0.21' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                payment_token: '1a2s3d4f5g6h7j',
                                cpf: '123.123.123-12', plan_id: '1')
      allow(Random).to receive(:rand).and_return(0.21)

      payment.change_status

      expect(payment.status).to eq('approved')
    end

    it 'status should be approved if random less or equal than 0.19' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                payment_token: '1a2s3d4f5g6h7j',
                                cpf: '123.123.123-12', plan_id: '1')
      allow(Random).to receive(:rand).and_return(0.19)

      payment.change_status

      expect(payment.status).to eq('refused')
    end
  end
end
