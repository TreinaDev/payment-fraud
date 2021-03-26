require 'rails_helper'

describe 'payment management' do
  context 'POST payment' do
    it 'should create a valid payment' do
      payment_method = FactoryBot.create(:payment_method)
      params = { payment:
                  { payment_method_id: payment_method.id,
                    customer_token: 'a1s2d3f4',
                    cpf: '123.123.123-12',
                    plan_id: '1', plan_price: '100.00', discount_price: nil } }
      payment_before_count = Payment.count

      post '/api/v1/payments', params: params

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
                    plan_id: '1', plan_price: 100.00 } }

      post '/api/v1/payments', params: params
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(json_response[:payment_token]).to eq(Payment.last.payment_token)
      expect(json_response[:customer_token]).to eq('a1s2d3f4')
    end

    it 'should return 422 if payment method does not exist' do
      params = { payment:
                  { payment_method_id: 3,
                    customer_token: 'a1s2d3f4',
                    cpf: '123.123.123-12',
                    plan_id: '1', plan_price: 100.00 } }

      post '/api/v1/payments', params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'GET payment' do
    it 'should render a payment information' do
      payment_method = FactoryBot.create(:payment_method)
      payment = Payment.create!(payment_method_id: payment_method.id,
                                customer_token: 'a1s2d3f4',
                                cpf: '123.123.123-12',
                                plan_id: '1', plan_price: 100.00)

      get "/api/v1/payments/#{payment.id}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_response[:customer_token]).to eq('a1s2d3f4')
      expect(json_response[:cpf]).to eq('123.123.123-12')
    end

    it 'should return 404 if payment not exists' do
      get '/api/v1/payments/1'

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json_response[:message]).to eq('não encontrado')
    end
  end
end
