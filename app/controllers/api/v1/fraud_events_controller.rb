module Api
  module V1
    class FraudEventsController < ApiController
      def create
        begin
          fraud_event = FraudEvent.new(event_fraud_params)
        rescue ArgumentError => e
          return render json: { error_message: e.message }, status: :unprocessable_entity
        end

        if fraud_event.save
          render json: fraud_event, except: %i[created_at updated_at], status: :created
        else
          render json: { error_message: fraud_event.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def event_fraud_params
        params.require(:fraud_event).permit(:cpf, :description, :event_severity)
      end
    end
  end
end
