module Api
  module V1
    class CpfsController < ApiController
      def show
        return render json: { blocked: Cpf.blocked?(params[:cpf]) }, status: :ok if Cpf.valid?(params[:cpf])

        render json: { error_message: 'CPF inválido' }, status: :bad_request
      end
    end
  end
end
