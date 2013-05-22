module Facades
  module Middleman
    class << self
      ##
      # Make helpers available to middleman
      # 
      def registered(app)
        app.send :include, Facades::Helpers
      end
      alias :included :registered
    end
  end
end

::Middleman::Extensions.register(:facades, Facades::Middleman) 