module Api
  module V1
    class CpfsController < ApiController
      def show
        if Cpf.valid?(params[:cpf])
          return render json: { blocked: Cpf.blocked?(params[:cpf]) }, status: :ok
        end

        render json: { error_message: 'CPF inválido' }, status: :bad_request
      end
    end
  end
end
