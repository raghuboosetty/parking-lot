require "bundler/setup"
require "aruba/rspec"

Dir[File.join(__dir__, '../../lib', '*.rb')].each { |file| require_relative file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.include Aruba::Api, type: :aruba

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Aruba.configure do |config|
  config.exit_timeout = 1
end
