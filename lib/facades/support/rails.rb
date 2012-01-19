require 'rails'

# Stub engine to integrate asset pipeline.
module Facades
  class Engine < Rails::Engine 
    
    require 'facades/helpers'
    require 'facades/builders/sprite'
    require 'sass'
    require 'sass/rails'
    
    config.sass.load_paths << File.expand_path("../../stylesheets", __FILE__)
    Facades::Builders::Sprite
    
    ActiveSupport.on_load(:action_controller) do
      include Facades::Helpers::MobileController
    end
    
    initializer 'facades assets' do |app|
      app.config.assets.instance_eval do
        register_mime_type 'image/png', '.png'
      end
    end
       
  end
end