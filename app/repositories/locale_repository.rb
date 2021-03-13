class LocaleRepository
  def find_or_create_by(**attrs)
    locale = Locale.find_or_create_by(attrs)
    return [false, locale.errors.messages] unless locale.valid?

    [true, locale]
  end
end
