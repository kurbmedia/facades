module Facades
  module Helpers
    ##
    # 
    # Convenience helpers for building navigation lists, and defining 'on' states.
    #
    module Navigation
      
      ##
      # 
      # Creates a link wrapped in a list item, to be used within a list-based navigation.
      # 
      # @param [String] text The text used within the link
      # @param [String] path The url used as the link's +href+ attribute
      # @param [Hash] attrs Hash of attributes to be applied to the link. This format is the same as Rail's +link_to+ helper
      # @option attrs [String] :active_class The class to use if this link is 'active'. Defaults to "on"
      # @option attrs [Proc] :proc A callback which, when called, determines the active state of the link
      # @option attrs [Regex] :matcher A regular expression to be matched against +path+
      # @param [Symbol] wrapper The html tag to be used as the wrapper. Defaults to +:li+
      # 
      # @example Create a list item link to any page
      #   nav_link('Home Page', '/home') #=> <li><a href="/home">Home Page</a>
      # 
      # @example 'Active state' functionality for the current page
      #   nav_link('Current Page', '/current_url') #=> <li class="on"><a href="/current_url" class="on">Current Page</a></li>
      # 
      def nav_link(text, path, attrs = {}, wrapper = :li, &block)
        
        if block_given?
          return sub_nav_link(text, path, attrs, wrapper, :ol, &block)
        end
        
        link_attrs    = update_link_attrs(path, attrs)
        wrapper_attrs = link_attrs.delete(:wrapper)      
        child_link    = link_to(text, path, link_attrs)
        built = (wrapper === false ? child_link : content_tag(wrapper, child_link, wrapper_attrs))
        built = built.html_safe if built.respond_to?(:html_safe)
        built
      end
      alias :nav_link_to :nav_link
      
      def sub_nav_link(text, path, attrs = {}, wrapper = :li, container = :ol, &block)
        wrapper_attrs = attrs.delete(:wrapper)
        link_attrs    = update_link_attrs(path, attrs.merge(:wrapper => (attrs.delete(:item) || {}) ))
        parent_link   = nav_link_to(text, path, attrs, false)
        child_links   = content_tag(container, capture(&block), wrapper_attrs)
        content_tag(wrapper, (parent_link << child_links), wrapper_attrs)
      end     
      private :sub_nav_link
      
      ##
      # 
      # Creates a navigational list format, including a parent list / wrapper. Useful for nested list navigation
      # @param [String] text The text used within the link
      # @param [String] path The url used as the link's +href+ attribute
      # @param [Hash] attrs Hash of attributes to be applied to the link. This format is the same as Rail's +link_to+ helper
      # @option attrs [String] :active_class The class to use if this link is 'active'. Defaults to "on"
      # @option attrs [Proc] :proc A callback which, when called, determines the active state of the link
      # @option attrs [Regex] :matcher A regular expression to be matched against +path+
      # @param [Symbol] wrapper The html tag to be used as the wrapper. Defaults to +:li+
      # @param [Symbol] container The element that will be used as a container for the nested list
      # @param [Block] &block A block containing the content of the nested items
      # 
      # @example Create a nested list navigation
      #   nav do
      #     nav_link('About Page', '/about')
      #   end
      # @example
      #   <ol>
      #     <li><a href="/home">Home Page</a>
      #       <ol>
      #           <li><a href="/about">Sub Page</a></li>
      #       </ol>
      #     </li>
      #   </ol>
      # 
      def nav(container = :ol, html_attrs = {}, heading = nil, &block)
        
        wrapper_attrs = html_attrs.delete(:wrapper) || {}
        
        built = if Facades.enable_html5
          inner = content_tag(container, capture(&block), wrapper_attrs)
          inner = (content_tag(:h3, heading) << inner) unless heading.nil?
          content_tag(:nav, html_attrs) do
            inner
          end          
        else
          content_tag(container, capture(&block), html_attrs)
        end
        built = built.html_safe if built.respond_to?(:html_safe)
        built
        
      end
      
      private
      
      # @private
      def update_link_attrs(path, attrs)
        
        proc          = attrs.delete(:proc) || false
        regex         = attrs.delete(:matcher) || false
        klasses       = attrs.delete(:class).try(:split, ' ')
        on_class      = attrs.delete(:active_class) || "on"
        wrapper_attrs = attrs.delete(:wrapper) || {}
        wklasses      = wrapper_attrs[:class].try(:split, ' ')
        
        klasses  ||= []
        wklasses ||= []
        
        matcher = (proc || regex || request.path)
        
        active = case matcher
          when Proc then proc.call(path)
          when Regexp then request.path.match(regex)
          when String then (request.path == path || request.path.match(/#{path}\/\w/im))
          else raise 'Proc, Regexp or String required... passed #{matcher.class}.'
        end
        
        if active
          klasses  << on_class
          wklasses << on_class
        end

        attrs.merge!(:class => klasses.join(" ")) unless klasses.compact.empty?
        wrapper_attrs.merge!(:class => wklasses.join(" ")) unless wklasses.compact.empty?
        
        attrs.merge!(:wrapper => wrapper_attrs)
                
      end
            
    end
    
  end
end