class Cpf
  def self.qualify?(cpf)
    fraud_events = FraudEvent.where(cpf: cpf)
    low_event = 0

    fraud_events.each do |fraud_event|
      return true if fraud_event.event_severity == 1

      low_event += 1
      return true if low_event == 3
    end

    false
  end
end
