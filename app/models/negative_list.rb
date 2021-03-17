class NegativeList < ApplicationRecord
    def self.block?(cpf)
        negative_cpf = self.find_by(cpf: cpf)
        unless negative_cpf
            return false
        end

        negative_cpf.expiration_date > DateTime.now
    end
end
