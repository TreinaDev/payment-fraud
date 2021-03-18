require 'rails_helper'

describe 'payment management' do
  context 'POST payment' do
    it 'should create a valid payment' do
      payment_method = FactoryBot.create(:payment_method)
      params = { payment:
                  { payment_method_id: payment_method.id,
                    customer_token: 'a1s2d3f4',
                    cpf: '123.123.123-12',
                    plan_id: '1' } }
      payment_before_count = Payment.count


      post '/api/v1/payment', params: params

      payment = Payment.last
      expect(payment.customer_token).to eq 'a1s2d3f4'
      expect(payment.plan_id).to eq '1'
      expect(payment.payment_method_id).to eq payment_method.id
      expect(Payment.count).to be > payment_before_count
    end

    it 'should return a payment data sucessfully' do
      payment_method = FactoryBot.create(:payment_method)
      params = { payment:
                  { payment_method_id: payment_method.id,
                    customer_token: 'a1s2d3f4',
                    cpf: '123.123.123-12',
                    plan_id: '1' } }

      post '/api/v1/payment', params: params
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:payment_token]).to eq(Payment.last.payment_token)
      expect(json_response[:customer_token]).to eq('a1s2d3f4')
    end
  end
end
