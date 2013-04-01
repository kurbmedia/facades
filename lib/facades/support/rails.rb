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
      app.config.assets.paths << File.join(Facades.app_path, 'assets')
    end
    
    initializer 'configure simple_form' do |app|
      begin
        require 'simple_form'
        ActiveSupport::Deprecation.warn("If you are upgrading Facades > 1.0.3, and rely on the simple form wrappers, please require facades/support/simple_form in an initializer.")
      rescue Exception => e
      end
    end
  end
end