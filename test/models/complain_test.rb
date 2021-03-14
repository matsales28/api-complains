require "test_helper"

class ComplainTest < ActiveSupport::TestCase
  validate_presence_test :complain, %i[description title company]

  test 'exists Complain class' do
    assert_instance_of Complain, build(:complain)
  end
end