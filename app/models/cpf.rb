require 'cpf_cnpj'

class Cpf
  def self.blocked?(cpf)
    NegativeList.blocked?(cpf)
  end

  def self.valid?(cpf)
    CPF.new(cpf).valid?
  end
end
