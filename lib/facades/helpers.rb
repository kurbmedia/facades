require 'action_view'
require 'facades/helpers/layout'
require 'facades/helpers/navigation'

module Facades
  module Helpers  
    include Facades::Helpers::Layout
    include Facades::Helpers::Navigation
  end
end