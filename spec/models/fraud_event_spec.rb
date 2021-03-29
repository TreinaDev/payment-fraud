require 'rails_helper'

RSpec.describe FraudEvent, type: :model do
  context 'Block CPF' do
    it 'with 1 high severity fraud event' do
      FactoryBot.create(:fraud_event, { cpf: '12345678900', event_severity: 1 })

      expect(NegativeList.blocked?('12345678900')).to be_truthy
    end

    it 'with 3 low severity fraud events' do
      3.times do 
        FactoryBot.create(:fraud_event, { cpf: '12345678900', event_severity: 0 })
      end

      expect(NegativeList.blocked?('12345678900')).to be_truthy
    end

    it 'does not block if less than 3 low severity fraud events' do
      FactoryBot.create(:fraud_event, { cpf: '12345678900', event_severity: 0 })

      expect(NegativeList.blocked?('12345678900')).to be_falsy
    end
  end
end
