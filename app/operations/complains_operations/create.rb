module ComplainsOperations
  class Create
    attr_reader :complain_repo, :locale_repo, :params

    def initialize(params:)
      # @complain_repo = ::ComplainRepository.new
      @locale_repo = LocaleRepository.new
      @params = params
    end

    def call
      success, response = locale_repo.find_or_create_by(params[:locale])
      return [response, :bad_request] unless success

      complain = Complain.new(title: params[:title], description: params[:description], company: params[:company], locale: response)
      return [complain.errors.messages, :bad_request] unless complain.save

      [complain, true]
    end
  end
end
