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
  extend ActionDispatch::TestProcess
  parallelize(workers: :number_of_processors)

  parallelize_setup do |worker|
    SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
  end
  parallelize_teardown do |_worker|
    SimpleCov.result
  end
end