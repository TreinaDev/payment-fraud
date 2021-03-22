class NegativeList < ApplicationRecord
  def self.blocked?(cpf)
    negative_cpf = find_by(cpf: cpf)

    return false unless negative_cpf

    negative_cpf.expiration_date > DateTime.now
  end
end
