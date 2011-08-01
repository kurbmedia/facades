module Facades
  module Helpers
    extend ActiveSupport::Concern
    
    autoload :Layout,     'facades/helpers/layout'
    autoload :Navigation, 'facades/helpers/navigation'
    autoload :Elements,   'facades/helpers/elements'
    
    included do
      include Facades::Helpers::Layout
      include Facades::Helpers::Navigation
      include Facades::Helpers::Elements
    end    
  end
end