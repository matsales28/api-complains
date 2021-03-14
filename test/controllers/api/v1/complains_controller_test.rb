require 'test_helper'

module Api
  module V1
    class ComplainsControllerTest < ActionDispatch::IntegrationTest
      def setup
        DatabaseCleaner.clean
      end
      test '#create should return a Complain and status :ok when valid params' do
        byebug
        params = {complain: {title: 'Mocking title', description: 'Mocking description', company: 'Gocase', locale: { city: 'Fortaleza', state: 'CE', country: 'BR'}}}
        post api_v1_create_path, params: params
        complain = Complain.first
        json_response = JSON.parse(response.body)

        assert_response :success
        assert_equal complain.description, json_response['description']
        assert_equal complain.title, json_response['title']
        assert_equal complain.company, json_response['company']
      end

      test '#create should return errors and status :unprocessable_entity when invalid params' do
        params = {complain: {title: nil, description: 'Mocking description', company: 'Gocase', locale: { city: nil, state: 'CE', country: 'BR'}}}
        post api_v1_create_path, params: params
        json_response = JSON.parse(response.body)

        assert_response :unprocessable_entity
        assert_equal ['can\'t be blank'], json_response['city']
      end

      test '#search should return errors and status :bad_request when no locale found for given params' do
        complain = create(:complain)
        params = {complain: {company: complain.company, city: 'Strange City', state: complain.locale.state, country: complain.locale.country}}
        get api_v1_search_path, params: params
        json_response = JSON.parse(response.body)

        assert_response :bad_request
        assert_equal 'No complains founded for this locale params', json_response['message']
      end

      test '#search should return count of complains when given valid params' do
        complain = create(:complain)
        params = {complain: {company: complain.company, city: complain.locale.city, state: complain.locale.state, country: complain.locale.country}}
        get api_v1_search_path, params: params
        json_response = JSON.parse(response.body)

        assert_response :success
        assert_equal 1, json_response['total_complains']
      end
    end
  end
end
