require 'rails'
require 'sass/rails'

##
# Integrates facades assets into the Rails asset pipeline. 
# 
module Facades
  class Engine < Rails::Engine 
    
    initializer 'load facades assets' do |app|
      app.config.sass.load_paths ||= []
      app.config.sass.load_paths << File.expand_path("../../../src", __FILE__)     
    end
    
  end
end