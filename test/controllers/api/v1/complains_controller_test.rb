require 'test_helper'

module Api
  module V1
    class ComplainsControllerTest < ActionDispatch::IntegrationTest
      test '#create should return a Complain and status :ok when valid params' do
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
    end
  end
end
