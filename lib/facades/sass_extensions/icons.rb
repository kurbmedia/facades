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
      # Create a sass list of icon names from an icon pack.
      # 
      def icon_names(set = "facades")
        listing = icon_translations(set)
        keys = (listing.keys || [])
        keys = keys.collect{ |k| Sass::Script::String.new(k) }
        Sass::Script::List.new(keys, ',')
      end
      
      ##
      # Maps a "pack" name to a font name.
      # 
      def icon_font(name)
        Sass::Script::String.new({ 
          'facades'       => 'FacadesRegular',
          'font-awesome'  => 'FontAwesome'
        }[name])
      end
      
      private
      
      def icon_translations(set)
        set = set.value if set.respond_to?(:value)
        glyphs = Icons.glyph_sets[set] || YAML::load(File.open(File.join(Facades.icon_path, "#{set}.yml")))
        Icons.glyph_sets[set] ||= Hash[glyphs.map{ |k, v| [k.to_s.gsub("_", "-"), v] }]
        Icons.glyph_sets[set]
      end
      
      def icon_glyph_value(name, set = 'facades')
        name  = name.to_s
        value = icon_translations(set)[name]
        if value.nil?
          raise Sass::SyntaxError, "The icon '#{name}' does not exist within icon pack #{set}."
        end
        value
      end
    end
  end
end