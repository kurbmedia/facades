require 'rails'

# Stub engine to integrate asset pipeline.
module Facades
  class Engine < Rails::Engine 
    
    require 'facades/helpers'
    require 'facades/builders/sprite'
    
    Facades::Builders::Sprite
    
    initializer 'facades assets' do |app|
      app.config.assets.instance_eval do
        register_mime_type 'image/png', '.png'
      end
    end
       
  end
end