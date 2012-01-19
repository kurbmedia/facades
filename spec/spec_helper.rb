$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'facades'
require 'rspec'
require 'sass'


RSpec.configure do |config|
end