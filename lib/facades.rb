require 'active_support/all'
require 'facades/version'

module Facades
  extend self
  autoload :Helpers,  'facades/helpers'
  autoload :Patterns, 'facades/patterns'
  
  def app_path
    File.expand_path("../../app", __FILE__)
  end
  
  def view_path
    File.join(File.expand_path("../../app", __FILE__), 'views')
  end
  
  def scss_path
    File.join(File.expand_path("../../src", __FILE__), 'scss')
  end
  
  def image_path
    File.join(File.expand_path("../../src", __FILE__), 'images')
  end
  
  def icon_path
    File.join(File.expand_path("../../src", __FILE__), 'icons')
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