module Facades
  module SassExt
    module FormElements
  
      def fields_of_type(*args)
        types = args.collect do |type|
          send(:"#{type}_input_types")
        end
        Sass::Script::String.new(types.join(", "))
      end
      
      private
      
      def all_input_types
        [:checkbox, :password, :radio, :select, :string, :textarea].collect{ |t| send(:"#{t}_input_types") }.flatten.compact
      end
      
      def button_input_types
        "input[type=submit], input[type=reset], button[type=submit]"
      end
      
      def checkbox_input_types
        "input[type=checkbox]"
      end
      alias :check_input_types :checkbox_input_types
      
      def password_input_types
        "input[type=password]"
      end
      
      def radio_input_types
        "input[type=radio]"
      end
      
      def select_input_types
        "select"
      end

      def string_input_types
        %w{email password text number search tel time url datetime date datetime-local week month}.collect do |type| 
          "input[type=#{type}]"
        end
      end
      
      def textarea_input_types
        "textarea"
      end

    end
    
  end
end