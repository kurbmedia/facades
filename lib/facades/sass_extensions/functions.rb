##
# Misc functions to assist development.
# 
module Facades
  module SassExtensions
    module Functions
      
      ##
      # Creates a selector including all 
      # fields of a particular type. Helpful to 
      # target text-like inputs etc.
      # 
      def input_types(*args)
        Sass::Script::String.new(args.collect do |type|
          send(:"#{type}_input_types")
        end.flatten.compact.join(", "))
      end
      
      ##
      # Compact via compass
      # Compacts a sass list removing any nil or empty items, or creates a new empty list.
      # @see http://compass-style.org
      # 
      def compact(*args)
        sep = :comma
        if args.size == 1 && args.first.is_a?(Sass::Script::List)
          list = args.first
          args = list.value
          sep  = list.separator
        end
        Sass::Script::List.new(args.reject{|a| !a.to_bool}, sep)
      end
      
      private
      
      ##
      # Returns all input types
      # 
      def all_input_types
        [boolean_input_types, button_input_types, text_input_types].flatten
      end
      
      ##
      # Returns an array of boolean input types (radio/checkbox)
      # 
      def boolean_input_types
        ["input[type=radio]", "input[type=checkbox]"]
      end
      
      ##
      # Returns an array of button style input types
      # 
      def button_input_types
        ["button", "input[type=button]", "input[type=submit]", "input[type=reset]"]
      end
      
      ##
      # Returns an array of text style input types
      # 
      def text_input_types
        %w{email password text number search tel time url datetime date datetime-local week month}.collect do |type| 
          "input[type=#{type}]"
        end
      end
      
    end
    
  end
end