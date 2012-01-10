module Facades
  module SassExt
    module Funcs

      ##
      # Compact via compass
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
    
      ##
      # Joins a list with spaces or returns a single element if the 
      # list only contains one item
      # 
      def spacify(list)
        if list.is_a?(Sass::Script::List)
          Sass::Script::List.new(list.value.dup, :space)
        else
          Sass::Script::List.new([list], :space)
        end
      end
      
   
    end # Funcs
  end # SassExt
end # Facades