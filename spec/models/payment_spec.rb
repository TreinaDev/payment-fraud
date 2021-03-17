require 'rails_helper'

describe Payment do
  context 'create new payment' do
    it 'successfully with all params' do
      payment_method = PaymentMethod.create
      Payment.create!(payment_method: payment_method, customer_token: 'a1s2d3f4',
                      payment_token: '123456', cpf: '123.123.123-12', plan_id: '1')

      expect(Payment.all.size).to eq 1
      expect(Payment.last.payment_token).to eq '123456'
    end

    it 'can not have blank attributes' do
      payment = Payment.new

      expect(payment.valid?).to be_falsy
      expect(payment.errors.count).to eq(5)
    end

    it 'payment token must be uniq' do
      payment_method = PaymentMethod.create
      payment_first = Payment.create!(payment_method: payment_method,
                                      customer_token: 'a1s2d3f4',
                                      payment_token: '123456',
                                      cpf: '123.123.123-12', plan_id: '1')

      payment_invalid = Payment.new(payment_method: payment_method,
                                    customer_token: 'a1s2d3f4',
                                    payment_token: '123456',
                                    cpf: '123.123.123-12', plan_id: '1')

      expect(payment_invalid.valid?).to be_falsy
      expect(payment_invalid.errors[:payment_token]).to include('token deve ser único')
    end
  end
end