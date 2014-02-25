require 'active_support/all'
require 'facades/version'

module Facades
  extend self
  autoload :Helpers,  'facades/helpers'
  autoload :Patterns, 'facades/patterns'
  autoload :Debug,    'facades/debug'
  
  ##
  # Path to the app dir for the Rails Engine
  # 
  def app_path
    File.expand_path("../../app", __FILE__)
  end
  
  
  ##
  # Accessor for the config
  # 
  def config
    return Config unless block_given?
    yield Config
  end
  
  
  ##
  # Path to any relevant Rails views
  # 
  def view_path
    File.join(File.expand_path("../../app", __FILE__), 'views')
  end
  
  
  ##
  # Where to load the SASS files.
  # 
  def scss_path
    File.join(File.expand_path("../../src", __FILE__), 'scss')
  end
  
  
  ##
  # Where image assets are stored.
  # 
  def image_path
    File.join(File.expand_path("../../src", __FILE__), 'images')
  end
  
  
  ##
  # Icon data for available icon packs
  # 
  def icon_packs
    @icon_packs ||= ActiveSupport::HashWithIndifferentAccess.new
  end
  
  
  ##
  # Where to find icon data
  # 
  def icon_path
    File.join(File.expand_path("../../src", __FILE__), 'icons')
  end
end

require 'facades/config'
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