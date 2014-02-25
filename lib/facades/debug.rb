module Facades
  module Debug
    extend self
    
    ##
    # Stores a list of all available SASS mixins.
    # 
    def available_mixins
      @avail_mixins ||= {}
    end
  end
end