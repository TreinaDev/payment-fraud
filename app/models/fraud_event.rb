class FraudEvent < ApplicationRecord
  enum event_severity: { low: 0, high: 1 }

  validate :validate_cpf
  validates :description, :event_severity, :cpf, presence: true
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

  def validate_cpf
    return if Cpf.valid?(cpf)

    errors.add :cpf, 'deve ser válido'
  end
end
