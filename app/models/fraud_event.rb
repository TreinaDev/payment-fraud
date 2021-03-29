class FraudEvent < ApplicationRecord
  after_save :block_cpf, if: :too_many_events?

  private

  def too_many_events?
    frauds_count = FraudEvent.where(cpf: cpf).size
    return false unless event_severity == 1 || frauds_count >= 3

    true
  end

  def block_cpf
    NegativeList.create(cpf: cpf,
                        expiration_date: 1.year.from_now)
  end
end
