class Cpf
  def self.blocked?(cpf)
    NegativeList.blocked?(cpf)
  end
end
