require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require :default, :development

Combustion.initialize! :action_controller, :action_view, :sprockets

require 'facades/support/rails'

begin
  require 'growl'
rescue LoadError
end

require 'rspec'
require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
end