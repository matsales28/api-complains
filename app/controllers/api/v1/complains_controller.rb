module Api
  module V1
    class ComplainsController < ApplicationController
      def create
        json_response(permitted_params)
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
