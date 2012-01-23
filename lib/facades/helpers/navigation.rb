module Facades
  module Helpers
    module Navigation
      
      ##
      # Constructs a navigation list containing 
      # a variable number of list items and links.
      # 
      def nav(options = {}, &block)
        Navigator.new(self, options).render(&block)
      end
      
      alias :navigation :nav
      
      ##
      # Similar to link_to, but adds the class 'active' 
      # if the link's href is in an active state.
      # If the options :proc, or :matcher is passed, 
      # they are used to determine active state. If not 
      # the current request.path is used.
      # 
      def nav_link(text, href, options = {})
        options.merge!(:path => request.path)
        link = NavigationLink.new(text, href, options)
        if link.active?
          link.options = Navigator.merge_html_classes('active', link.options)
        end
        link_to(link.text, link.href, link.options)
      end
      
      class Navigator
        attr_reader :view, :path
        attr_accessor :options, :nested
        
        def initialize(tpl, options = {}, nested = false)
          @view, @options, @nested = tpl, options, nested
          @path = view.request.path
        end
        
        delegate :content_tag, :concat, :link_to, :to => :view
        
        ##
        # Renders the resulting html list, wrapped in a <nav> tag.
        # 
        def render(&block)
          wrap_attrs = options.delete(:wrapper) || :ul
          unless wrap_attrs.is_a?(Hash)
            wrapper    = wrap_attrs
            wrap_attrs = {}
          else
            wrapper = wrap_attrs.delete(:tag) || :ul
          end
          
          output = view.capture(self, &block)
          output = content_tag(wrapper, output, options)
          return output if nested?
          concat(content_tag(:nav, output, wrap_attrs))
        end
        
        ##
        # Constructs a link wrapped in a list item for use 
        # within a navigation list.
        # 
        def link(text, href, link_opts = {}, &block)          
          
          wrap_attrs = link_opts.delete(:wrapper) || {}
          link_opts.merge!(:path => path)
          link = NavigationLink.new(text, href, link_opts)
          
          if link.active?
            wrap_attrs   = merge_html_classes("active", wrap_attrs)
            link.options = merge_html_classes("active", link.options)
          end
          
          if block_given?
            subnav = Navigator.new(view, wrap_attrs, true, &block)
            output = link_to(link.text, link.href, link.options) << subnav.render(&block) 
            concat content_tag(:li, output, wrap_attrs)
          else
            concat content_tag(:li, link_to(link.text, link.href, link.options), wrap_attrs)
          end          
        end
        
        class << self
          
          ##
          # Takes an options array and adds any additional 
          # classes passed to args. If a :class key exists, it 
          # is updated. If not, it is added unless the result is
          # an empty string. 
          # 
          def merge_html_classes(*args)
            opts    = args.extract_options!
            klasses = (opts.delete(:class) || "").split(" ")
            klasses = [klasses, args].flatten.compact.reject{ |c| c.to_s.blank? }.join(" ")
            (klasses.blank? ? opts : opts.merge!(:class => klasses))
          end
          
        end
        
        private
        
        def merge_html_classes(*args) #:nodoc:
          Navigator.merge_html_classes(*args)
        end
        
        ##
        # Determines if the current navigation set 
        # is nested within another.
        # 
        def nested?
          @nested == true
        end

      end
      
      class NavigationLink
        attr_accessor :href, :text, :options
        attr_reader :matcher
        
        def initialize(text, href, options)
          @href, @text, @options = href, text, options
          @matcher  = (options.delete(:proc) || options.delete(:matcher))
          curr_path = options.delete(:path)
          @matcher ||= curr_path
        end
        
        ##
        # Checks the link's href against either a proc,
        # regexp, or current request.path depending on 
        # the options provided. Returns true if there is 
        # a match, false if not.
        # 
        def active?
          return matcher.call(href) if matcher.is_a?(Proc)
          return ( (href =~ matcher).to_i >= 1 ) if matcher.is_a?(Regexp)
          match_path = matcher.to_s.sub(/^\//, '')
          href_path  = href.to_s.sub(/^\//, '')
          (match_path == href_path || match_path.match(/#{href_path}\/\w/i))
        end
        
      end
      
    end # Navigation
    
  end # Helpers
  
end # Facades