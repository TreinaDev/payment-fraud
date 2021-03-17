require 'rails_helper'

describe 'billing management' do
  context 'POST payment' do
    it 'should return a payment data sucessfully' do
      resp_json = [{"payment_token": "XYZ", "payment_method": "Boleto"}]
      payment_doule = double('Payment', status: 200, body: resp_json)
      allow(Faraday).to receive(:post).with('/api/v1/payment').and_return(payment_doule)

      post '/api/v1/payment'

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:payment_token]).to eq(payment.token)
      expect(json_response[:payment_method]).to eq('Boleto')
      #expect(json_response[:customer_token]).to eq('xxx')
      #expect(response.body).to have_content('Cobrança efetuada com sucesso')
    end
  end
end
