require 'rails_helper'

RSpec.describe NegativeList, type: :model do
  context 'CPF' do
    it 'successfully adding' do
      negative_cpf = NegativeList.create!(cpf: '123.456.789-00', 
        expiration_date: '16/03/2022')
      
      aux = NegativeList.find(negative_cpf.id)

      expect(aux).to eq(negative_cpf)
    end

    it '#block? true' do
      NegativeList.create!(cpf: '123.456.789-00', 
        expiration_date: '16/03/2022')
      result = NegativeList.block?('123.456.789-00')
      expect(result).to eq true
    end

    it '#block? false in list' do
      NegativeList.create!(cpf: '123.456.789-00', 
        expiration_date: '16/01/2020')
      result = NegativeList.block?('123.456.789-00')
      expect(result).to eq false
    end

    it '#block? false out list' do
      result = NegativeList.block?('123.456.789-00')
      expect(result).to eq false
    end
  end
end
