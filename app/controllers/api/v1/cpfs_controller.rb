module Api
  module V1
    class CpfsController < ApiController
      def show
        result = NegativeList.blocked? params[:cpf]
        render json: { blocked: result }, status: :ok
      end
    end
  end
end
