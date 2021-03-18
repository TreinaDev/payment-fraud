require 'rails_helper'

describe 'Payment methods management' do
  context 'GET payment methods' do
    it 'should render payment method information' do
      pm = create(:payment_method)
      other_pm = create(:payment_method, name: 'Boleto', code: 'BOLETO', max_installments: 5)

      get '/api/v1/payment_methods'

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[0][:name]).to eq('Cartão de crédito')
      expect(json_response[0][:code]).to eq('CCRED')
      expect(json_response[0][:max_installments]).to eq(10)
      expect(json_response[1][:name]).to eq('Boleto')
      expect(json_response[1][:code]).to eq('BOLETO')
      expect(json_response[1][:max_installments]).to eq(5)
    end

    it 'should return empty if does not exist payment method' do
      get '/api/v1/payment_methods'

      # TODO: mock rspec para active error
      expect(response).to have_http_status :not_found
    end
  end
end
