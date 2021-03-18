require 'rails_helper'

describe 'Payment methods management' do
  context 'GET payment methods' do
    it 'should render all payment methods' do
      pm = create(:payment_method)
      other_pm = create(:payment_method, name: 'Boleto', code: 'BOLETO', max_installments: 5)

      get '/api/v1/payment_methods'

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(json_response.length).to eq(2)
      expect(json_response.first[:name]).to eq(pm.name)
      expect(json_response.first[:code]).to eq(pm.code)
      expect(json_response.first[:max_installments]).to eq(pm.max_installments)
      expect(json_response.last[:name]).to eq(other_pm.name)
      expect(json_response.last[:code]).to eq(other_pm.code)
      expect(json_response.last[:max_installments]).to eq(other_pm.max_installments)
    end

    it 'should return empty if do not have any payment method registered' do
      get '/api/v1/payment_methods'

      # TODO: mock rspec para active error
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(json_response.empty?).to eq(true)
    end
  end
end
