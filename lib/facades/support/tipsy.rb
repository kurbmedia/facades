require 'facades/helpers'
require File.expand_path("../../../../app/helpers/", __FILE__) << '/facades_helper'

module Facades
  module Support
    # Enable facades helpers and files within serve projects
    # see github.com/kurbmedia/tipsy for more info.
    module Tipsy
      extend ActiveSupport::Concern
      
      included do
        include ::FacadesHelper
      end
      
    end    
  end
end