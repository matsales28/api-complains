require 'test_helper'

class LocaleRepositoryTest < ActiveSupport::TestCase
  test '#find_or_create return array with success and locale given valid params' do
    params = {city: 'Fortaleza', state: 'CE', country: 'Brazil'}
    response, success = LocaleRepository.new.find_or_create_by(params)
    assert success
    assert_instance_of Locale, response
  end

  test '#find_or_create_by given invalid params should return array with false and errors' do
    params = {city: nil, state: nil, country: nil}
    response, success = LocaleRepository.new.find_or_create_by(params)
    assert_not success
    assert response.new_record?
    assert_not_empty response.errors.messages
  end

  test '#find_or_create_by should not create a new Locale if founded one' do
    locale = create(:locale)
    response, success = LocaleRepository.new.find_or_create_by({city: locale.city, country: locale.country, state: locale.state})

    assert success
    assert_not response.new_record?
    assert_instance_of Locale, response
  end

  test '#locale_ids_by when nil params return all locale ids' do
    params = {city: nil, country: nil, state: nil}
    create(:locale)
    array_of_ids, success = LocaleRepository.new.locale_ids_by(params)
    assert success
    assert_not_empty array_of_ids
  end

  test '#locale_ids_by if any params givens do not match locale, return array empty' do
    params = {city: 'Fortaleza', country: 'Brazil', state: 'SP'}
    create(:locale, city: 'Fortaleza', country: 'Brazil', state: 'CE')
    array_of_ids, success = LocaleRepository.new.locale_ids_by(params)
    assert_not success
    assert_empty array_of_ids
  end
end
