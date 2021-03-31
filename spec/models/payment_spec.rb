require 'rails_helper'

describe Payment do
  context 'create' do
    it 'can not create payment if payment method status is inactive' do
      payment_method = FactoryBot.create(:payment_method, status: :inactive)
      payment = FactoryBot.build(:payment, payment_method: payment_method, plan_price: 10.5)

      expect(payment).not_to be_valid
    end

    it 'successfully with all params' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12', plan_price: 100.00,
                                plan_id: '1')

      expect(Payment.all.size).to eq 1
      expect(Payment.last.payment_token).to eq payment.payment_token
    end

    it 'can not have blank attributes' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.new(payment_method: payment_method)

      expect(payment.valid?).to be_falsy
      expect(payment.errors.count).to eq(5)
    end

    it 'payment_token must be uniq' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment_first = Payment.create!(payment_method: payment_method,
                                      customer_token: 'a1s2d3f4',
                                      payment_token: '1a2s3d4f5g6h7j',
                                      cpf: '123.123.123-12', plan_price: 100.00,
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
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.new(payment_method: payment_method,
                            customer_token: 'a1s2d3f4',
                            cpf: '123.123.123-12', plan_id: '1',
                            plan_price: nil, discount_price: 50)

      expect(payment.valid?).to be_falsy
    end

    it 'cannot have a negative plan price' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.new(payment_method: payment_method,
                            customer_token: 'a1s2d3f4',
                            cpf: '123.123.123-12', plan_id: '1',
                            plan_price: -10)

      expect(payment.valid?).to be_falsy
      expect(payment.errors[:plan_price]).to include('deve ser maior que 0')
    end
  end

  context 'status' do
    it 'is pending when created' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12', plan_price: 100.00,
                                plan_id: '1')

      expect(payment.status).to eq('pending')
    end
  end

  context '.change_status' do
    it 'status should be approved if random bigger or equal than 0.21' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                payment_token: '1a2s3d4f5g6h7j',
                                cpf: '123.123.123-12', plan_price: 100.00,
                                plan_id: '1')
      allow(Random).to receive(:rand).and_return(0.21)

      payment.change_status

      expect(payment.status).to eq('approved')
    end

    it 'status should be approved if random less or equal than 0.19' do
      payment_method = FactoryBot.create(:payment_method, status: :active)
      payment = Payment.create!(payment_method: payment_method,
                                customer_token: 'a1s2d3f4',
                                payment_token: '1a2s3d4f5g6h7j',
                                cpf: '123.123.123-12', plan_price: 100.00,
                                plan_id: '1')
      allow(Random).to receive(:rand).and_return(0.19)

      payment.change_status

      expect(payment.status).to eq('refused')
    end
  end
end
