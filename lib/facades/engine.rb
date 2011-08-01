# Stub engine to integrate asset pipeline.
module Facades
  class Engine < Rails::Engine 
    
    require 'facades/helpers'
    
    initializer 'facades assets' do |app|
    end
       
  end
end