module ComplainsOperations
  class Search
    attr_reader :complain_repo, :locale_repo, :params

    def initialize(params:)
      @complain_repo = ComplainRepository.new
      @locale_repo = LocaleRepository.new
      @params = params
    end

    def call
      locale_ids, success = locale_repo.locale_ids_by(locale_params)
      return [{message: 'No complains founded for this locale params'}, success] unless success

      count, success = complain_repo.count_by_locale_and_company(locale_ids: locale_ids, company: params[:company])
      [{total_complains: count}, success]
    end

    private
      def locale_params
        {
          city: params[:city],
          state: params[:state],
          country: params[:country]
        }
      end
  end
end
