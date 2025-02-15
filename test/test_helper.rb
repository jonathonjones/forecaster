ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "vcr"
require "webmock"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    VCR.configure do |c|
      c.cassette_library_dir = "test/vcr_cassettes"
      c.hook_into :webmock
    end
  end
end
