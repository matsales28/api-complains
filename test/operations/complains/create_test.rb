require 'test_helper'

module Complains
  class CreateTest < ActiveSupport::TestCase
    def setup
      @valid_complain_params = {title: 'Mocking title', description: 'Mocking description', company: 'Gocase', locale: { city: 'Fortaleza', state: 'CE', country: 'BR'}}
    end

    test 'return an error and false when no locale given' do
      @valid_complain_params[:locale] = {}
      response, success = ComplainsOperations::Create.new(params: @valid_complain_params).call
      assert_not success
      assert_not_instance_of Complain, response
    end

    test 'return an complain and :ok when everything pass' do
      response, success = ComplainsOperations::Create.new(params: @valid_complain_params).call
      assert_instance_of Complain, response
      assert success
    end
  end
end
