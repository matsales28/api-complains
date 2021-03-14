module ComplainsOperations
  class Create
    def initialize
      @complain_repo = ComplainRepository.new
      @locale_repo = LocaleRepository.new
    end

    def self.call(params)
      locale = Lo
      complain = Complain.new(complain_parans, locale)
    end
  end
end