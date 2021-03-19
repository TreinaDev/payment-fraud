require 'cpf_cnpj'

module Api
  module V1
    class CpfsController < ApiController
      def show
        cpf = CPF.new(params[:cpf])
        if cpf.valid?
          result = NegativeList.blocked? params[:cpf]
          return render json: { blocked: result }, status: :ok
        end
        render json: { error_message: 'CPF inválido' }, status: :bad_request
      end
    end
  end
end
