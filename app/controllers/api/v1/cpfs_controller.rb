require 'cpf_cnpj'

module Api
  module V1
    class CpfsController < ApiController
      def show        
        if CPF.new(params[:cpf]).valid?
          return render json: { blocked: Cpf.blocked?(params[:cpf]) }, status: :ok
        end

        render json: { error_message: 'CPF inválido' }, status: :bad_request
      end
    end
  end
end
