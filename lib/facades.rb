require 'active_support/all'
require 'facades/version'

module Facades
end

if defined?(Rails)
  require 'facades/support/rails'
end

if defined?(Compass)
  require 'facades/support/compass'
end