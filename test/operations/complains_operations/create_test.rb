require 'test_helper'

module ComplainsOperations
  class CreateTest < ActiveSupport::TestCase
    def setup
      @valid_complain_params = {title: 'Mocking title', description: 'Mocking description', company: 'Gocase'}
    end

    test 'return an error when no locale given' do
      assert_raises StandardError, 'Invalid locale given' do
        Complains::Create.call(@valid_complain_params, nil)
      end
    end
  end
end
