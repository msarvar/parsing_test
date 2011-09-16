# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
require File.expand_path("init.rb")

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rr

end
