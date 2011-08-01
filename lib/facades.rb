require 'active_support'
require 'facades/version'

module Facades
  
  module Debug
    autoload :Html, 'facades/debug/html'
  end
  
  mattr_accessor :enable_html5
  mattr_accessor :debug_html

  def setup(&block)
    yield self
  end
  
end

Facades.enable_html5 = true
Facades.debug_html   = true

require 'facades/sass_ext'
require 'compass'
Compass::Frameworks.register('facades',
  :stylesheets_directory => File.join(File.dirname(__FILE__), 'facades/stylesheets'),
  :templates_directory   => File.join(File.dirname(__FILE__), 'facades/templates'))

require 'facades/engine' if defined?(Rails)