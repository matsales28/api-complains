class LocaleRepository
  include Responseable

  def find_or_create_by(city:, country:, state:)
    locale = Locale.find_or_create_by(city: city, country: country, state: state)
    return Error[locale] unless locale.valid?

    Success[locale]
  end
end
