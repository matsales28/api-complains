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

  test '#count_by_locale_and_company return count of complains' do
    locale = create(:locale)
    complain = create(:complain, locale: locale)
    complain_repo = ComplainRepository.new
    complains_count, success = complain_repo.count_by_locale_and_company(locale_ids: [locale.id], company: complain.company)

    assert success
    assert_equal 1, complains_count
  end
end
