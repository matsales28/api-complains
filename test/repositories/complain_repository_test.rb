require 'test_helper'

class ComplainRepositoryTest < ActiveSupport::TestCase
  test '#create return a new Complain if given correct params' do
    locale = create(:locale)
    params = {
      locale: locale,
      title: 'Title mock',
      description: 'Description mock',
      company: 'Company mock'
    }

    complain, success = ComplainRepository.new.create(params)
    assert_instance_of Complain, complain
    assert success
  end

  test '#create return complain and not success if given invalid params' do
    locale = create(:locale)
    params = {
      locale: locale,
      description: 'Description mock',
      company: 'Company mock',
      title: nil
    }
    response, success = ComplainRepository.new.create(params)
    assert response.new_record?
    assert_not_empty response.errors.messages
    assert_not success
  end
end
