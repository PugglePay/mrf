require 'rspec/autorun'

require_relative '../lib/mrf'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
end

def fixture_path (path)
  File.join(File.dirname(__FILE__), "fixtures/#{path}")
end

def fixture (path)
  File.read(fixture_path(path))
end
