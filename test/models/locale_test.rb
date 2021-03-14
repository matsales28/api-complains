require 'test_helper'
class LocaleTest < ActiveSupport::TestCase
  validate_presence_test :locale, %i[city state country]
end
