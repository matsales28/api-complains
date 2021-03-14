module ComplainsOperations
  class Create
    attr_reader :complain_repo, :locale_repo, :params

    def initialize(params:)
      @complain_repo = ComplainRepository.new
      @locale_repo = LocaleRepository.new
      @params = params
    end

    def call
      locale_response, success = locale_repo.find_or_create_by(locale_params)
      return [locale_response, :bad_request] unless success

      complain_response, success = complain_repo.create(complain_params.merge({locale: locale_response}))
      return [complain_response.errors.messages, :bad_request] unless success

      [complain_response, :ok]
    end

    private
      def complain_params
        {
          title: params[:title],
          description: params[:description],
          company: params[:company]
        }
      end

      def locale_params
        {
          city: params.dig(:locale, :city),
          state: params.dig(:locale, :state),
          country: params.dig(:locale, :country)
        }
      end
  end
end
