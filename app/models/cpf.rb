require 'cpf_cnpj'
class Cpf
  def self.blocked?(cpf)
    NegativeList.blocked?(cpf)
  end

  def self.valid?(cpf)
    CPF.new(cpf).valid?
  end

  def self.qualify?(cpf)
    fraud_events = FraudEvent.where(cpf: cpf)
    return true if fraud_events.count >= 3

    fraud_events.each do |fraud_event|
      return true if fraud_event.event_severity == 1
    end
    false
  end
end
