require 'compass'

##
# Creates the facades compass extension
# 
Compass::Frameworks.register('facades', 
  :stylesheets_directory => File.expand_path("../../../src", __FILE__),
  :templates_directory   => File.join(File.dirname(__FILE__), 'compass'))