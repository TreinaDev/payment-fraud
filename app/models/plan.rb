class Plan  #PORO
  attr_reader :name

  def self.all
    #response = Faraday.get("#{Rails.configuration.external_apis['plan_api']}/plans")
    #json_response = JSON.parse(response.body, symbolize_names: true)
    
    ###APAGAR (SÒ TEST)
    file = open("./spec/support/apis/plans.json")
    json = file.read
    json_response = JSON.parse(json, symbolize_names: true)

    plans = []
    json_response.each do |r| 
      plans << Plan.new(name: r[:name])
    end

    return plans
  end 
  
  def initialize(name:)
    @name = name
  end
end 