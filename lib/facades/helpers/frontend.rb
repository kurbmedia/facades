require 'chunky_png'

module Facades
  module Helpers
    ##
    # Misc helpers for front-end development.
    # 
    module Frontend
      
      def placeholder_image(*args)
        @_placeholder_image_cache ||= ImageCache.new
        options = args.extract_options!
        image_tag(@_placeholder_image_cache.get(args), options)
      end
      
      ##
      # Caches placeholder image data based on 
      # a md5 hash. 
      # 
      class ImageCache
        
        def get(args)
          hash    = ::Digest::MD5.hexdigest("#{args.join('|')}")
          return cache[hash] if cache[hash].present?
          
          width   = args.shift
          height  = (args.shift || width)
          color   = (args.shift || '#cccccc')
          text    = args.shift
          
          cache[hash] = generate_png(width, height, color, text)
        end
        
        
        private
        
        def cache
          @_cache ||= {}
        end
        
        ##
        # Generates an image based on the provided parameters.
        # 
        # 
        def generate_png(width, height, color, text = nil)
          color   = color.sub(/^#/, '')
          color   = "#{color}#{color}" if color.size <= 3
          color   = ChunkyPNG::Color.from_hex("##{color}")
          image   = ChunkyPNG::Image.new(width, height, color)
          image.to_data_url
        end
      end
    end
  end
end