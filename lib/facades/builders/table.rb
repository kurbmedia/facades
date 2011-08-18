module Facades
  module Builders
    class TableBuilder
      attr_reader :template, :options, :resources, :buffer
      
      def initialize(resources, tpl, options)
        @buffer = ""
        @template, @options, @resources = tpl, options, resources
      end
      
      delegate :content_tag, :to => :template
      
      ##
      # Get a list of all headings for the table
      # Use the resource class's table_headings method first, options hash next
      # 
      def headings
        return resource_class.table_attributes if resource_class.respond_to?(:table_headings)
        [options[:headings]].flatten.compact
      end
      
      ##
      # The class for this resource
      def resource_class
        resources.first.class
      end
      
      ##
      # Renders the table content immediately using the provided options
      def inline!
        [head, body].map(&:to_s).join("\n")
      end
      
      def head
        return content_tag(:thead, render_heading) unless block_given?        
        content_tag(:thead) do
          yield self
        end
      end
      
      def body
        return content_tag(:tbody, render_body) unless block_given?        
        content_tag(:tbody) do
          yield self
        end
      end
      
      private
      
      # Render an entire body inline
      def render_body
        rows = []
        resources.each_with_index do |res, index|
          attrs = { :class => (ind.even? ? 'even' : 'odd') }
          buff = content_tag(:tr, attrs) do
            headings.collect do |hd|
              content_tag(:td, res.send(:"#{hd}"))
            end.to_s.join("\n")
          end
          rows << buff
        end
        rows.map(&:to_s).join("\n")
      end
      
      # Render entire body inline
      def render_heading
        buffer << template.content_tag(:thead) do
          headings.collect do |hd|
            content_tag(:th, hd)
          end.to_s.join("\n")
        end
      end
      
    end
  end
end