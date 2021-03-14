class LocaleRepository
  include Responseable

  def find_or_create_by(**attrs)
    locale = Locale.find_or_create_by(attrs)
    return Error[locale.errors.messages] unless locale.valid?

    Success[locale]
  rescue Mongoid::Errors::MongoidError => e
    Error[{message: 'Invalid attributes given', error: e}]
  end
end
