module Facades
  module Helpers
    extend ActiveSupport::Concern
    
    autoload :Layout,     'facades/helpers/layout'
    autoload :Navigation, 'facades/helpers/navigation'
    autoload :Elements,   'facades/helpers/elements'
    autoload :Pagination, 'facades/helpers/pagination'
    
    included do
      include Facades::Helpers::Layout
      include Facades::Helpers::Navigation
      include Facades::Helpers::Elements
      include Facades::Helpers::Pagination
    end
    
  end
end