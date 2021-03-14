class ComplainRepository
  include Responseable

  def create(locale:, title:, description:, company:)
    complain = Complain.new(
      title: title,
      company: company,
      description: description,
      locale: locale
    )
    return Error[complain] unless complain.save

    Success[complain]
  end

  def count_by_locale_and_company(locale_ids:, company:)
    complains_count = Complain.by_company(company)
                              .where(:locale_id.in => locale_ids)
                              .count
    Success[complains_count]
  end
end
