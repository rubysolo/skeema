require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'rspec'
require 'rspec/autorun'

RSpec.configure do |config|
  config.mock_with :rspec
end
