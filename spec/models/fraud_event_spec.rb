require 'rails_helper'

RSpec.describe FraudEvent, type: :model do
  context 'Block CPF' do
    it 'with 1 high severity fraud event' do
      FactoryBot.create(:fraud_event, { cpf: '53282085796', event_severity: :high })

      expect(NegativeList.blocked?('53282085796')).to be_truthy
    end

    it 'with 3 low severity fraud events' do
      3.times do
        FactoryBot.create(:fraud_event, { cpf: '53282085796', event_severity: :low })
      end

      expect(NegativeList.blocked?('53282085796')).to be_truthy
    end

    it 'does not block if less than 3 low severity fraud events' do
      FactoryBot.create(:fraud_event, { cpf: '53282085796', event_severity: :low })

      expect(NegativeList.blocked?('53282085796')).to be_falsy
    end

    it 'should block for 12 months' do
      FactoryBot.create(:fraud_event, { cpf: '53282085796', event_severity: :high })
      blocked_cpf = NegativeList.find_by(cpf: '53282085796')

      expect(NegativeList.blocked?('53282085796')).to be_truthy
      expect(blocked_cpf.expiration_date.strftime('%F')).to eq(1.year.from_now.strftime('%F'))
    end

    it 'only if cpf is valid' do
      fraud_event = FraudEvent.new(cpf: '11111111111', description: 'teste', event_severity: :high)

      expect(fraud_event.valid?).to eq(false)
      expect(fraud_event.errors.full_messages).to include('CPF deve ser válido')
      expect(fraud_event.errors.count).to eq(1)
    end
  end
end
