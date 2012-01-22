require 'active_support/all'
require 'facades/version'

module Facades
  autoload :Helpers,  'facades/helpers'
  autoload :Patterns, 'facades/patterns'
end

require 'facades/sass_extensions'

##
# Use the rails pipeline directly unless functioning 
# in a non-rails environment. Otherwise include the
# compass extension.
# 
if defined?(Rails)
  require 'facades/support/rails'
else
  require 'facades/support/compass'
end