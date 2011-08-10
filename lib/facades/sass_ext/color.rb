module Facades
  module SassExt
    module Color
      
      # Check the luminance of color. This differs from lightness as it returns the actual values as 'light' and 'dark'
      def luminance(color)
        assert_type color, :Color
        result = ((color.red * 299) + (color.green * 587) + (color.blue * 114) / 1000)
        Sass::Script::String.new( result >= 160 ? 'light' : 'dark')
      end
      
      # Tint a color by mixing it with white
      def tint(color, dilution = Sass::Script::Number.new(50))
        assert_type color, :Color
        white = Sass::Script::Color.new([255, 255, 255, 1])
        assert_type dilution, :Number
        mix(color, white, Sass::Script::Number.new(100 - dilution.value))
      end

      # Shade a color by mixing it with black
      def shade(color, dilution = Sass::Script::Number.new(50))
        assert_type color, :Color
        black = Sass::Script::Color.new([0, 0, 0, 1])
        assert_type dilution, :Number
        mix(color, black, Sass::Script::Number.new(100 - dilution.value))
      end
      
    end
  end
end