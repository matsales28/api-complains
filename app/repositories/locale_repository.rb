class LocaleRepository
  Error = -> (response) { [response, false] }
  Success = -> (response) { [response, true] }

  def find_or_create_by(**attrs)
    locale = Locale.find_or_create_by(attrs)
    return Error[locale.errors.messages] unless locale.valid?

    Success[locale]
  rescue Mongoid::Errors::MongoidError => _e
    ## Log error
    Error[{message: 'Invalid attributes given'}]
  end
end
