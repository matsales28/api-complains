require 'test_helper'

module Complains
  class SearchTest < ActiveSupport::TestCase
    def setup
      super
      @locale = build(:locale)
      @complain = build(:complain, locale: @locale)
      @params = {company: @complain.company, locale: { city: @locale.city, country: @locale.country, state: @locale.state}}
    end

    test 'return an complain and :ok when everything pass' do
      @locale.save
      @complain.save
      response, success = ComplainsOperations::Search.new(params: @params).call
      assert_equal({total_complains: 1}, response)
      assert success
    end

    test 'return an error message and false when no locale found with given params' do
      response, success = ComplainsOperations::Search.new(params: @params).call
      assert_not success
      assert_equal({message: 'No complains founded for this locale params'}, response)
    end
  end
end
