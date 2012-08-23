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
      # Similar to link_to, but adds the class 'active' if the link's href is in an active state.
      # If the options :proc, or :matcher is passed, they are used to determine active state. If not the current 
      # request.path is used.
      # 
      def nav_link(text, href, options = {})
        options.merge!(:path => request.path)
        wrapper = options.delete(:wrapper)
        link    = NavigationLink.new(text, href, options)
        current = link.active?
        link.options = Navigator.merge_html_classes('active', link.options) if current

        if wrapper
          if wrapper.is_a?(Hash)
            wrap_attrs = wrapper
            wrapper    = wrap_attrs.delete(:tag) || :li
          else
            wrap_attrs = {}
          end
          wrap_attrs = Navigator.merge_html_classes('active', wrap_attrs) if current
          return content_tag(wrapper, link_to(link.text, link.href, link.options), wrap_attrs)
        end
        
        link_to(link.text, link.href, link.options)
      end
      
      class Navigator
        attr_reader :view, :path
        attr_accessor :options, :nested, :links
        
        def initialize(tpl, options = {}, nested = false)
          @view, @options, @nested, @links = tpl, options, nested, []
          @path = view.request.path
        end
        
        delegate :content_tag, :concat, :link_to, :to => :view
        
        ##
        # Renders the resulting html list, wrapped in a <nav> tag.
        # 
        def render(&block)
          wrap_attrs = options.delete(:wrapper) || :ul
          heading    = options.delete(:heading)
          
          unless wrap_attrs.is_a?(Hash)
            wrapper    = wrap_attrs
            wrap_attrs = {}
          else
            wrapper = wrap_attrs.delete(:tag) || :ul
          end
          
          @wrapper_attrs = wrap_attrs
          @wrapper       = wrapper
          
          output = content_tag(wrapper, view.capture(self, &block), options)
          return output if nested?
          
          if heading
            heading = generate_heading(heading)
            output  = heading << output
          end
          content_tag(:nav, output, wrap_attrs)
          
        end
        
        ##
        # Constructs a link wrapped in a list item for use 
        # within a navigation list.
        # 
        def link(text, href, link_opts = {}, &block)          
          
          wrap_attrs = link_opts.delete(:wrapper) || {}
          link_opts.merge!(:path => path)
          link = NavigationLink.new(text, href, link_opts)
          links << link
          
          if link.active?
            wrap_attrs   = merge_html_classes("active", wrap_attrs)
            link.options = merge_html_classes("active", link.options)
          end
          
          if block_given?
            subnav = Navigator.new(view, wrap_attrs, true)
            inner  = subnav.render(&block)
            unless subnav.links.empty?
              output = link_to(link.text, link.href, link.options) << inner
              content_tag(:li, output, wrap_attrs)
            else
              content_tag(:li, link_to(link.text, link.href, link.options), wrap_attrs)
            end
          else
            content_tag(:li, link_to(link.text, link.href, link.options), wrap_attrs)
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
            (klasses.blank? ? opts : opts.merge(:class => klasses))
          end
          
        end
        
        private

        ##
        # To be valid, a <nav> should have a heading of some sort.
        # When passed via options, this generates the proper tag
        # 
        def generate_heading(opts)
          if opts.is_a?(Hash)
            heading_tag  = opts.delete(:tag)
            heading_text = opts.delete(:text)
          else 
            heading_text = opts
          end
          heading_tag ||= :h3
          content_tag(heading_tag, heading_text)
        end
        
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
          
          match_path = normalize_path(matcher)
          href_path  = normalize_path(href)
          
          return false if href_path.blank? && !match_path.blank?
          
          if key = options.delete(:match)
            path_matcher = case key.to_s
            when 'exact'  then match_path.match(%r{^/?#{href_path}/?$}i)
            when 'after'  then match_path.match(%r{/?#{href_path}/?(.*)$}i)
            when 'before' then match_path.match(%r{#{href_path}/?$}i)
            end
          else
            path_matcher = match_path.match(/#{href_path}\/.*/i)
          end
          !!(match_path == href_path || path_matcher)
        end
        
        private
        
        def normalize_path(path)
          path.split("/").reject{ |part| part.blank? }.compact.join("/")
        end
        
      end
      
    end # Navigation
    
  end # Helpers
  
end # Facades