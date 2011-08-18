require 'facades/builders/table'

module Facades
  module Helpers
    module Builders

      def table_for(resource_or_class, *args, &block)
        options    = args.extract_options!
        html_attrs = options.delete(:html)
        builder    = options.delete(:builder) || TableBuilder
        builder    = builder.new(resource_or_class, self, options)
        
        unless block_given?
          content_tag(:table, builder.inline!, html_attrs)
        else
          content_tag(:table, html_attrs) do
            yield builder
          end
        end        
      end
      
    end
  end
end