class LocaleRepository
  include Responseable

  def find_or_create_by(city:, country:, state:)
    locale = Locale.find_or_create_by(city: city, country: country, state: state)
    return Error[locale] unless locale.valid?

    Success[locale]
  end

  def locale_ids_by(city:, country:, state:)
    ids = Locale.by_city(city)
                .by_state(state)
                .by_country(country)
                .pluck(:id)
    return Error[ids] unless ids.present?

    Success[ids]
  end
end
