require 'active_support'
require 'active_support/core_ext/object'
require 'facades/version'

module Facades
  
  module Support
    autoload :Serve, 'facades/support/serve'
  end
  
  module Debug
    autoload :Html, 'facades/debug/html'
  end
  
  module Builders
    autoload :Sprite, 'facades/builders/sprite'
    autoload :Form, 'facades/builders/form'
  end
  
  # When enabled, HTML5 elements are used within helpers
  # This includes things like using <nav> within pagination
  # and the nav helper.
  #
  mattr_accessor :enable_html5
  @@enable_html5 = true
  
  # When enabled, a div is added to each HTML page which displays
  # errors with the resulting html. This includes things like missing page titles,
  # missing keywords, etc.
  # 
  mattr_accessor :debug_html
  @@debug_html = false
  
  def self.helpers
    Facades::Helpers
  end

  def setup(&block)
    yield self
  end
  
end

require 'facades/sass_ext'
require 'compass'
Compass::Frameworks.register('facades',
  :stylesheets_directory => File.join(File.dirname(__FILE__), 'facades/stylesheets'),
  :templates_directory   => File.join(File.dirname(__FILE__), 'facades/templates'))

require 'facades/support/rails' if defined?(Rails)