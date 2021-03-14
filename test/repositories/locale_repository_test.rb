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
    assert_equal({
      city: ['can\'t be blank'],
      state: ['can\'t be blank'],
      country: ['can\'t be blank']}, response)
  end

  test '#find_or_create_by should not create a new Locale if founded one' do
    params = {city: 'Fortaleza', state: 'CE', country: 'Brazil'}
    create(:locale, params)
    response, success = LocaleRepository.new.find_or_create_by(params)
    
    assert success
    assert_not response.new_record?
    assert_instance_of Locale, response
  end

  test '#find_or_create_by with invalid attributes' do
    response, success = LocaleRepository.new.find_or_create_by(teste: 'bla')
    assert_not success
    assert_equal 'Invalid attributes given', response[:message]
  end
end
