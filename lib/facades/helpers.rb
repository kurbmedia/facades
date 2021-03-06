require 'action_view'
require 'facades/helpers/layout'
require 'facades/helpers/navigation'
require 'facades/helpers/notifications'

module Facades
  module Helpers  
    autoload :Frontend, 'facades/helpers/frontend'
    
    include Facades::Helpers::Layout
    include Facades::Helpers::Navigation
    include Facades::Helpers::Notifications
  end
end