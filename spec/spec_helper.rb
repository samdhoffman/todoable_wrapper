require "bundler/setup"
require "todoable_wrapper"

# dependencies
require 'webmock/rspec'
require 'vcr'

WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
  
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/todoable_cassettes'
  c.hook_into :webmock
end