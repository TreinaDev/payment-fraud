require 'rails_helper'

describe Plan do
  context 'fetch API data' do
    it 'should get all plans from enrollment' do
      plans_json = File.read(Rails.root.join('spec/support/apis/plans.json'))
      plans_double = double('faraday_response', status: 200, body: plans_json)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/plans')
                                     .and_return(plans_double)

      plans = Plan.all

      expect(plans.length).to eq 2
      expect(plans.first.name).to eq('Plano Black')
      expect(plans.last.name).to eq('Plano Smart')
    end

    it 'should return empty if not found' do
      resp_double = double('faraday_response', status: :not_found, body: '')

      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/plans')
                                     .and_return(resp_double)

      plans = Plan.all

      expect(plans.length).to eq 0
    end
  end
end
