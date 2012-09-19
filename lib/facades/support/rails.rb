require 'rails'
require 'sass/rails'

##
# Integrates facades assets into the Rails asset pipeline. 
# 
module Facades
  class Engine < Rails::Engine 
    
    paths['app/views']       << Facades.view_path
    paths['app/controllers'] << File.join(Facades.app_path, 'controllers')
    
    initializer 'load facades assets' do |app|
      app.config.sass.load_paths ||= []
      app.config.sass.load_paths << Facades.scss_path
    end
    
    initializer 'configure simple_form' do |app|
      begin
        require 'simple_form'
        require 'facades/support/simple_form'
      rescue Exception => e
      end
    end
  end
end