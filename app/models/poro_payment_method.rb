class PoroPaymentMethod

  attr_reader :name, :code

  def initialize(name:, code:)
    @name = name
    @code = code
  end

  def self.all
    response = Faraday.get('pagamentos.com.br/api/v1/payment_methods')

    return {} unless response.status == 200

    json_response = JSON.parse(response.body, symbolize_names: true)

    result = json_response.map do |r|
      r = new(name: r[:name], code: r[:code])
    end

    result
  end
end
