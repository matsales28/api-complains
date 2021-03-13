require 'simplecov'
require 'simplecov-console'
require 'minitest/reporters'

class Minitest::Reporters::SpecReporter
  def record_print_status(test)
    print_colored_status(test)
    # rubocop:todo Style/FormatStringToken
    time = test.time
    print(' (%.2fs)' % time) unless time.nil?
    # rubocop:enable Style/FormatStringToken
    test_name = test.name.gsub(/^test_: /, 'test:')
    print pad_test(test_name)
    puts
  end
end

SimpleCov.start 'rails' do
  add_filter 'application_cable'
  add_filter 'application_job.rb'
  add_filter 'application_mailer.rb'
end
# For tests performance tuning:
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
Minitest::Reporters.use! Minitest::Reporters::MeanTimeReporter.new
# Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
# Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

DatabaseCleaner[:mongoid].clean_with :deletion
DatabaseCleaner[:mongoid].strategy = :deletion


SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ]
)

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  extend ActionDispatch::TestProcess
  parallelize(workers: :number_of_processors)

  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
  end
  parallelize_teardown do |_worker|
    SimpleCov.result
  end

  def around(&block)
    DatabaseCleaner.cleaning do
      yield block
    end
  end


  def self.validate_presence_test(model, fields = [])
    fields.each do |field|
      test "validates [#{model}] [#{field}] presence" do
        object = build(:"#{model}", "#{field}": '')
        assert_not object.valid?
        assert_not_empty object.errors[:"#{field}"]
        object = build(:"#{model}")
        assert object.valid?
      end
    end
  end
end
