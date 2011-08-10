require 'tilt'

module Facades
  module Builders
    class Sprite < Tilt::Template

      def prepare
      end
      
      def evaluate(scope, locals, &block)
        sprites = sprite_context(scope)
        sprites.instance_eval data
        sprites = sprites.send(:fetch!).uniq
        File.open(sprites.first).read
      end
      
      def locate_sprite_folder(scope)
        paths, name = scope.environment.paths, File.basename(scope.logical_path)
        paths.detect{ |p| File.directory?(File.join(p, name)) }
      end
      
      def sprite_context(scope)
        cxt = SpriteContext.new
        cxt.root      = locate_sprite_folder(scope)
        cxt.base_path = File.basename(scope.logical_path)
        cxt
      end
    
      class SpriteContext        
        attr_accessor :base_path, :sprite_images, :root
        def images(*args)
          @sprite_images = args
        end
        private
        def fetch!
          @sprite_images ||= Dir.glob(File.join(root, base_path, '*.png'))
        end        
      end
    
    end
    
  end
end

begin
  require 'sprockets'
  Sprockets::Engines
  Sprockets.register_engine '.sprite', Facades::Builders::Sprite
rescue LoadError
end