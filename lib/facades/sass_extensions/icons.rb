module Facades
  module SassExtensions
    module Icons
      class << self
        
        def glyph_sets
          @glyph_sets ||= {}
        end
        
      end
      
      ##
      # Creates a unicode entity for use in a content: description in css.
      # 
      def icon_glyph(name, set = 'facades')
        Sass::Script::String.new("\\#{icon_glyph_value(name, set)}")
      end
      
      
      ##
      # Creates a entity representation of the unicode character.
      # Used in IE7/legacy support.
      #
      def icon_entity(name, set = 'facades')
        Sass::Script::String.new("&#xf#{icon_glyph_value(name, set)};&nbsp;")
      end
      
      
      ##
      # Maps a "pack" name to a font name.
      # 
      def icon_font_name(name)
        Sass::Script::String.new({ 
          'facades'       => 'FacadesRegular',
          'font-awesome'  => 'FontAwesome'
        }[name])
      end
      
      
      ##
      # Get the url for the icon font file, based on type.
      # Only works if the font author has provided a cdn 
      # ( such as font awesome )
      # 
      def icon_font_url(name, type, extra = '')
        name  = name.value if name.respond_to?(:value)
        type  = type.value if type.respond_to?(:value)
        fonts = icon_data(name)['fonts']
        url   = fonts[type.to_s].to_s
        ::Rails.logger.info(url.inspect)
        Sass::Script::String.new(url)
      end
      
      
      ##
      # Create a sass list of icon names from an icon pack.
      # 
      def icon_names(set = "facades")
        listing = icon_translations(set)
        keys = (listing.keys || [])
        keys = keys.collect{ |k| Sass::Script::String.new(k) }
        Sass::Script::List.new(keys, ',')
      end
      
      
      ##
      # Shows relevant version information on an icon pack
      # 
      def icon_version(set = 'facades')
        set = set.value if set.respond_to?(:value)
        Sass::Script::String.new(icon_data(set)['version'])
      end
      
      
      private
      
      
      ##
      # Return all of the glyph data for a particular icon pack
      # 
      def icon_translations(set)
        set = set.value if set.respond_to?(:value)
        glyphs = icon_data(set)['icons'].dup
        Icons.glyph_sets[set] ||= Hash[glyphs.map{ |k, v| [k.to_s.gsub("_", "-"), v] }]
      end
      
      
      ##
      # Get the CSS "content" value for an icon by name
      # 
      def icon_glyph_value(name, set = 'facades')
        name  = name.to_s
        value = icon_translations(set)[name]
        if value.nil?
          raise Sass::SyntaxError, "The icon '#{name}' does not exist within icon pack #{set}."
        end
        value
      end
      
      
      ##
      # Loads icon data unless it was previously loaded.
      # 
      def icon_data(name)
        name = name.to_s.underscore.to_sym
        Facades.icon_packs[name] || Facades.icon_packs.merge!(name => YAML::load( File.open( Facades.config.icon_definitions[name] ) ))
        Facades.icon_packs[name]
      end
    end
  end
end