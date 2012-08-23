##
# Extensions to sass's unit conversion and manipulation 
# functionality. 
# 
module Facades
  module SassExtensions
    module Conversions
      
      ##
      # Removes any unit values (px/em/rem etc)
      # from a number leaving just the numeric
      # representation.
      # 
      # @example Use unitless line heights
      #   line-height:numeric(1em)  #=> line-height:1
      # 
      def numeric(value)
        assert_type value, :Number
        return value if value.unitless?
        value = value.to_s.gsub(value.unit_str, '')
        value = value.to_f.denominator > 1 ? value.to_f : value.to_i
        Sass::Script::Number.new(value)
      end
      
    end
  end
end