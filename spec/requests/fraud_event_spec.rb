require 'rails_helper'
require 'cpf_cnpj'

describe 'Fraud event' do
  context 'POST' do
    it 'new fraud event' do
      cpf = CPF.generate
      params = { fraud_event: { cpf: cpf, description: 'descrição de teste', event_severity: 'low' } }

      post '/api/v1/fraud_events', params: params

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)
      expect(json_response[:cpf]).to eq(cpf)
      expect(json_response[:description]).to eq('descrição de teste')
      expect(json_response[:event_severity]).to eq('low')
    end

    it 'fail if invalid cpf' do
      params = { fraud_event: { cpf: '11111111111', description: 'descrição de teste', event_severity: 'low' } }

      post '/api/v1/fraud_events', params: params

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response[:error_message]).to include('CPF deve ser válido')
    end

    it 'must have description and event_severity ' do
      cpf = CPF.generate
      params = { fraud_event: { cpf: cpf, description: '' } }

      post '/api/v1/fraud_events', params: params

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response[:error_message]).not_to include('CPF deve ser válido')
      expect(json_response[:error_message]).to include('Descrição não pode ficar em branco')
      expect(json_response[:error_message]).to include('Nível de criticidade não pode ficar em branco')
    end

    it 'event severity cannot be invalid' do
      cpf = CPF.generate
      params = { fraud_event: { cpf: cpf, description: 'descrição de teste', event_severity: 10 } }

      post '/api/v1/fraud_events', params: params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
