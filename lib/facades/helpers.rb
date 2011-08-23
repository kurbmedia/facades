require 'facades/helpers/layout'
require 'facades/helpers/navigation'
require 'facades/helpers/elements'
require 'facades/helpers/pagination'
require 'facades/helpers/utility'
require 'facades/helpers/builders'
require 'facades/helpers/mobile'

module Facades
  module Helpers
    extend ActiveSupport::Concern
    
    included do
      include Facades::Helpers::Layout
      include Facades::Helpers::Navigation
      include Facades::Helpers::Elements
      include Facades::Helpers::Pagination
      include Facades::Helpers::Utility
      include Facades::Helpers::Builders
      include Facades::Helpers::Mobile
    end
    
  end
end