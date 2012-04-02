module Facades
  module SassExtensions
    module Icons
      class << self
        
        def glyph_sets
          @glyph_sets ||= {}
        end
        
      end

      def icon_glyph(name, use_entity = false)
        name  = name.to_s
        value = icon_translations[name]
        if value.nil?
          raise Sass::SyntaxError, "The icon '#{name}' does not exist."
        end
        ## So we can support IE7 (TODO: Add time spent to ongoing invoice for microsoft)
        value = (use_entity ? "&#x#{value};" : "\\#{value}")
        Sass::Script::String.new(value)
      end
      
      def icon_names(set = "ui")
        listing = icon_translations(set)
        Sass::Script::List.new((listing.keys || []))
      end
      
      private
      
      def icon_translations(set = "ui")
        glyphs = Icons.glyph_sets[set] || YAML::load(File.open(File.join(Facades.image_path, 'icons', set, 'icons.yml')))
        Icons.glyph_sets[set] ||= Hash[glyphs.map{ |k, v| [k.to_s.gsub("_", "-"), v] }]
        Icons.glyph_sets[set]
      end
    
    end
  end
end