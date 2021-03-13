require 'test_helper'

class LocaleRepositoryTest < ActiveSupport::TestCase
  test '#find_or_create return array with success and locale given valid params' do
    params = {city: 'Fortaleza', state: 'CE', country: 'Brazil'}
    success, response = LocaleRepository.new.find_or_create_by(params)
    assert success
    assert_instance_of Locale, response
  end

  test '#find_or_create_by given invalid params should return array with false and errors' do
    params = {city: nil, state: nil, country: nil}
    assert_no_changes 'Locale.count' do
      success, response = LocaleRepository.new.find_or_create_by(params)
      assert_not success
      assert_equal({
        city: ['can\'t be blank'],
        state: ['can\'t be blank'],
        country: ['can\'t be blank']}, response)
    end
  end

  test '#find_or_create_by should not create a new Locale if founded one' do
    params = {city: 'Fortaleza', state: 'CE', country: 'Brazil'}
    Locale.create(params)
    assert_no_changes 'Locale.count' do
      success, response = LocaleRepository.new.find_or_create_by(params)
      assert success
      assert_instance_of Locale, response
    end
  end
end
