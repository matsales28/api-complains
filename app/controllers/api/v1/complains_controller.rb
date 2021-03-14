module Api
  module V1
    class ComplainsController < ApplicationController
      def create
        response, success = ComplainsOperations::Create.new(params: create_params).call
        if success
          json_response(response, :ok)
        else
          json_response(response.errors.messages, :unprocessable_entity)
        end
      end

      def search
        response, success = ComplainsOperations::Search.new(params: search_params).call
        return json_response(response, :bad_request) unless success

        json_response(response, :ok)
      end

      private
        def search_params
          params.require(:complain).permit(:company, :city, :state, :country)
        end

        def create_params
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
