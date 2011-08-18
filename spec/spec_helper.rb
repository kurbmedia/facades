$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'facades'
require 'facades/helpers'
require 'rspec'
require 'sass'
require 'compass'


RSpec.configure do |config|
end