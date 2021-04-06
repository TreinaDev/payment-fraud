class Plan
  attr_reader :name

  def self.all
    response = Faraday.get("#{Rails.configuration.external_apis['plan_api']}/plans")
    return [] if response.status == :not_found

    json_response = JSON.parse(response.body, symbolize_names: true)

    plans = []
    json_response.each do |r|
      plans << Plan.new(name: r[:name])
    end

    plans
  end

  def initialize(name:)
    @name = name
  end
end
