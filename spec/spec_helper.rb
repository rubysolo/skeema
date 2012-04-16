require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'rspec'
require 'rspec/autorun'

def fixture_path(filename)
  File.join(File.dirname(__FILE__), "fixtures/#{ filename }")
end

RSpec.configure do |config|
  config.mock_with :rspec
end
