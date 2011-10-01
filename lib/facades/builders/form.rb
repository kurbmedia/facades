require 'facades/builders/form/base'
require 'facades/builders/form/elements'
require 'facades/builders/form/helper'

module Facades
  module Builders
    class Form < ActionView::Helpers::FormBuilder #:nodoc:
      include Facades::Builders::FormBuilder::Base
      include Facades::Builders::FormBuilder::Elements      
      
      def with_custom_error_proc(&block)
        default_proc = ::ActionView::Base.field_error_proc
        ::ActionView::Base.field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
        yield
      ensure
        ::ActionView::Base.field_error_proc = default_proc
      end
      
      ActionView::Base.send(:include, Facades::Builders::FormHelper)
    end
  end
end