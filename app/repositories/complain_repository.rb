class ComplainRepository
  include Responseable

  def create(locale:, title:, description:, company:)
    complain = Complain.new(
      title: title,
      company: company,
      description: description,
      locale: locale
    )
    return Error[complain.errors.messages] unless complain.save

    Success[complain]
  end
end
