module Api
  module V1
    class ComplainsController < ApplicationController
      def create
        @complain, success = ComplainsOperations::Create.new(params: permitted_params).call
        if success
          json_response(@complain, :ok)
        else
          json_response(@complain.errors.messages, :unprocessable_entity)
        end
      end

      private
        def permitted_params
          params.require(:complain)
                .permit(
                  :title,
                  :description,
                  :company,
                  locale: [:city, :state, :country]
                )
        end
    end
  end
end
