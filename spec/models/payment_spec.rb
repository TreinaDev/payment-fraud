require 'rails_helper'

describe Payment do
  context 'create' do
    it 'successfully with all params' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method: payment_method, 
                                customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12',plan_price: 100.00,
                                 plan_id: '1')

      expect(Payment.all.size).to eq 1
      expect(Payment.last.payment_token).to eq payment.payment_token
    end

    it 'can not have blank attributes' do
      payment = Payment.new

      expect(payment.valid?).to be_falsy
      expect(payment.errors.count).to eq(5)
    end

    it 'payment_token must be uniq' do
      payment_method = FactoryBot.create(:payment_method)
      payment_first = Payment.create!(payment_method: payment_method,
                                      customer_token: 'a1s2d3f4',
                                      payment_token: '1a2s3d4f5g6h7j',
                                      cpf: '123.123.123-12',plan_price: 100.00,
                                      plan_id: '1')

      payment_invalid = Payment.new(payment_method: payment_method,
                                    customer_token: 'a1s2d3f4',
                                    payment_token: '1a2s3d4f5g6h7j',
                                    cpf: '123.123.123-12', plan_price: 100.00,
                                    plan_id: '1')

      expect(payment_invalid.payment_token).to eq(payment_first.payment_token)
      expect(payment_invalid.valid?).to eq false
      expect(payment_invalid.errors[:payment_token]).to include('Token deve ser único')
    end

    it 'must include a valid plan price and discounted price' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.new(payment_method: payment_method, 
                            customer_token: 'a1s2d3f4',
                            cpf: '123.123.123-12', plan_id: '1', 
                            plan_price: nil, discount_price: 50)

      expect(payment.valid?).to be_falsy
    end
  end

  context 'status' do
    it 'is pending when created' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method: payment_method, 
                                customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12', plan_price: 100.00,
                                plan_id: '1')

      expect(payment.status).to eq('pending')
    end
  end
end