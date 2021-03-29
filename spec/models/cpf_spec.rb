require 'rails_helper'

RSpec.describe Cpf, type: :model do
  context 'CPF' do
    it 'not blocking without occurrence' do
      result = Cpf.qualify?('12345678900')

      expect(result).to eq false
    end

    it 'not blocking with two low occurrence' do
      FraudEvent.create!(cpf: '12345678900', event_severity: 0, description: 'teste 1')
      FraudEvent.create!(cpf: '12345678900', event_severity: 0, description: 'teste 2')

      result = Cpf.qualify?('12345678900')

      expect(result).to eq false
    end

    it 'blocking with one high occurrence' do
      FraudEvent.create!(cpf: '12345678900', event_severity: 1, description: 'teste 1')

      result = Cpf.qualify?('12345678900')

      expect(result).to eq true
    end

    it 'blocking with three low occurrence' do
      FraudEvent.create!(cpf: '12345678900', event_severity: 0, description: 'teste 1')
      FraudEvent.create!(cpf: '12345678900', event_severity: 0, description: 'teste 2')
      FraudEvent.create!(cpf: '12345678900', event_severity: 0, description: 'teste 3')

      result = Cpf.qualify?('12345678900')

      expect(result).to eq true
    end
  end
end
