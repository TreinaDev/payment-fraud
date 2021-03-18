require 'rails_helper'

describe 'Consult CPF' do
  context 'GET CPF' do
    it 'without restriction' do
      cpf = '12345678900'
      get "/api/v1/cpfs/#{cpf}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:blocked]).to eq(false)
    end

    it 'with active restriction' do
      cpf = '12345678900'
      NegativeList.create!(cpf: cpf, expiration_date: 1.month.from_now)

      get "/api/v1/cpfs/#{cpf}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:blocked]).to eq(true)
    end

    it 'with expired constraint' do
      cpf = '12345678900'
      NegativeList.create!(cpf: cpf, expiration_date: 1.month.ago)
      get "/api/v1/cpfs/#{cpf}"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json_response[:blocked]).to eq(false)
    end
  end
end
