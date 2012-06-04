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
        keys = (listing.keys || [])
        keys = keys.collect{ |k| Sass::Script::String.new(k) }
        Sass::Script::List.new(keys, ',')
      end
      
      private
      
      def icon_translations(set = "ui")
        set = set.value if set.respond_to?(:value)
        glyphs = Icons.glyph_sets[set] || YAML::load(File.open(File.join(Facades.image_path, 'icons', set, 'icons.yml')))
        puts glyphs.inspect
        Icons.glyph_sets[set] ||= Hash[glyphs.map{ |k, v| [k.to_s.gsub("_", "-"), v] }]
        Icons.glyph_sets[set]
      end
    
    end
  end
end