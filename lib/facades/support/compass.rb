require 'compass'
##
# Creates the facades compass extension
# 
Compass::Frameworks.register('facades', 
  :stylesheets_directory => Facades.scss_path,
  :templates_directory   => File.join(File.dirname(__FILE__), 'compass'))

require 'facades/sass_extensions'