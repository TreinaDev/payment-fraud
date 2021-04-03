require 'rails_helper'

describe 'Payment methods management' do
  context 'GET payment methods' do
    it 'should render all payment methods' do
      pm = create(:payment_method, status: :active)
      pm.icon.attach(io: File.open(Rails.root.join('spec/support/storage/mastercard_icon.svg')),
                     filename: 'mastercard_icon.svg')
      other_pm = create(:payment_method, name: 'Boleto', code: 'BOLETO', max_installments: 5, status: :active)
      other_pm.icon.attach(io: File.open(Rails.root.join('spec/support/storage/boleto.svg')), filename: 'boleto.svg')

      get '/api/v1/payment_methods'

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(json_response.length).to eq(2)
      expect(json_response.first[:id]).to eq(pm.id)
      expect(json_response.first[:name]).to eq(pm.name)
      expect(json_response.first[:code]).to eq(pm.code)
      expect(json_response.first[:max_installments]).to eq(pm.max_installments)
      expect(json_response.first[:icon][:id]).to eq(pm.icon.id)
      expect(json_response.first[:icon][:blob][:id]).to eq(pm.icon.blob.id)
      expect(json_response.first[:icon][:blob][:key]).to eq(pm.icon.blob.key)
      expect(json_response.first[:icon][:blob][:filename]).to eq(pm.icon.blob[:filename])
      expect(json_response.last[:id]).to eq(other_pm.id)
      expect(json_response.last[:name]).to eq(other_pm.name)
      expect(json_response.last[:code]).to eq(other_pm.code)
      expect(json_response.last[:max_installments]).to eq(other_pm.max_installments)
      expect(json_response.last[:icon][:id]).to eq(other_pm.icon.id)
      expect(json_response.last[:icon][:blob][:id]).to eq(other_pm.icon.blob.id)
      expect(json_response.last[:icon][:blob][:key]).to eq(other_pm.icon.blob.key)
      expect(json_response.last[:icon][:blob][:filename]).to eq(other_pm.icon.blob[:filename])
    end

    it 'should return empty if do not have any payment method registered' do
      get '/api/v1/payment_methods'

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(json_response.empty?).to eq(true)
    end
  end
end
