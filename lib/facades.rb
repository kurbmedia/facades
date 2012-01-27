require 'active_support/all'
require 'facades/version'

module Facades
  extend self
  autoload :Helpers,  'facades/helpers'
  autoload :Patterns, 'facades/patterns'
  
  def scss_path
    File.expand_path("../../src", __FILE__) << "/scss"
  end
  
  def image_path
    File.expand_path("../../src", __FILE__) << "/images"
  end
  
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