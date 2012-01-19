require 'rails'

##
# Integrates facades assets into the Rails asset pipeline. 
# 
module Facades
  class Engine < Rails::Engine 
    config.sass.load_paths << File.expand_path("../../../src", __FILE__)     
  end
end