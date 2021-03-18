require 'rails_helper'

RSpec.describe NegativeList, type: :model do
  context 'CPF' do
    it 'successfully adding' do
      negative_cpf = NegativeList.create!(cpf: '12345678900', expiration_date: 1.month.from_now)
      aux = NegativeList.find(negative_cpf.id)

      expect(aux).to eq(negative_cpf)
    end

    it '#block? true' do
      NegativeList.create!(cpf: '12345678900', expiration_date: 1.month.from_now)
      result = NegativeList.blocked?('12345678900')
      expect(result).to eq true
    end

    it '#block? false in list' do
      NegativeList.create!(cpf: '12345678900', expiration_date: 1.month.ago)
      result = NegativeList.blocked?('12345678900')
      expect(result).to eq false
    end

    it '#block? false out list' do
      result = NegativeList.blocked?('12345678900')
      expect(result).to eq false
    end
  end
end
