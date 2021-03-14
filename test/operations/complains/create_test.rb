require 'test_helper'

module Complains
  class CreateTest < ActiveSupport::TestCase
    def setup
      @valid_complain_params = {title: 'Mocking title', description: 'Mocking description', company: 'Gocase', locale: { city: 'Fortaleza', state: 'CE', country: 'BR'}}
    end

    test 'return an error message and :bad_request status when no locale given' do
      @valid_complain_params[:locale] = {}
      response, status = ComplainsOperations::Create.new(params: @valid_complain_params).call
      assert_not_empty response[:locale]
      assert_equal :bad_request, status
    end
  end
end
