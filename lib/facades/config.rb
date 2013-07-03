module Facades
  module Config
    extend self
    
    def icon_definitions
      {
        :font_awesome => File.join(Facades.icon_path, 'font-awesome.yml'),
        :facades      => File.join(Facades.icon_path, 'facades.yml')
      }
    end
  end
end