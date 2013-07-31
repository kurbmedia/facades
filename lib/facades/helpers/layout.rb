module Facades
  module Helpers
    ##
    # Convenience helpers generally used in layout files
    #
    module Layout
      ##
      # Returns a short-hand string identifying the current browser
      # 
      def browser_name
        uastr = request.user_agent.to_s
        return "webkit"  if uastr =~ /(webkit)[ \/]([\w.]+)/i
        return "opera"   if uastr =~ /(opera)(?:.*version)?[ \/]([\w.]+)/i
        if matches = uastr.match(/(msie) ([\w.]+)/i)
          version = (matches[2]||0).to_i
          return "ie#{version}"
        end
        return "mozilla" if uastr =~ /(mozilla)(?:.*? rv:([\w.]+))?/i    
        "unknown"
      end
      
      ##
      # 
      # Allows easy assigning of meta tags from templates
      # @param [Symbol] name Name of the meta tag (ie: keywords / description)
      # @param [String] content The content to be used in the meta tag
      # @return [String] A html meta tag with the name and content attributes set
      # 
      def meta_tag(name, content)
        tag(:meta, :name => name, :content => content)
      end
    
      ##
      # Create a script tag for activating google analytics
      # @param [String] site_id The site ID provided by google analytics
      # @return [String] script tag
      # 
      def google_analytics(site_id, &block)
        return "" if defined?(Rails) && Rails.env != "production"
        content_tag(:script) do          
          %Q{
            var _gaq=[['_setAccount','#{site_id}'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
            #{(block_given? ? capture(&block) : "")}
        	}
      	end.html_safe
      end
      
      ##
      # 
      # Creates a page id to be used for identifying a page for CSS/design purposes. If a variable
      # is defined, it will be used. If not, one will be generated from the current controller/action.
      # 
      # @param [String] content The string to be used as the page id.
      # @return [String] The assigned page id
      # @example Create a page_id and use it in the body tag
      #   <%= page_id('home') %>
      #   
      #   <body id="<%= page_id %>"> #=> <body id="home">
      # 
      # @example Defaulting page id to controller/action
      #   # IndexController#home
      #   <body id="<%= page_id %>"> #=> <body id="index_home">
      # 
      # 
      def page_id(content = nil)
        return (@view_flow.get(:page_id).present? ? @view_flow.get(:page_id) : default_page_title_for_view) unless content
        provide(:page_id, content) if content
      end
      
      ##
      # 
      # Convenience method to create a page title for the <title></title> tag.
      # 
      # @param [String] content The text for the page title
      # @return [String] The provided content
      # @example Set the page title from a view template
      #   <%= page_title('This is my page title') %>
      # 
      #   # In the layout:
      #   <title><%= page_title %></title> #=> <title>This is my page title</title>
      # 
      def page_title(content = nil)
        provide(:page_title, content) and return if content
        return @view_flow.get(:page_title) unless content
        ""
      end

      ##
      # 
      # Configures a "robots" meta tag based on the rails environment. In environments other than 'production'
      # it sets the value to "noindex, nofollow" for each page that uses the layout in which it is called. This
      # helps prevent spiders from crawling / indexing content when used on staging sites.
      # 
      # @return [String] A html meta tag for "robots" with the appropriate content attribute set
      # 
      def robot_meta_tag
        tag(:meta, :name => 'robots', :content => (Rails.env.eql?('production') ? 'index, follow' : 'noindex, nofollow'))
      end

      
      private
      
      ##
      # Constructs a default page title from the current 
      # controller and action
      # 
      def default_page_title_for_view
        if defined?(controller)
          cname = controller.class.to_s.gsub(/controller$/i,'').underscore.split("/").join('_')
          aname = controller.action_name
          return "#{cname}_#{aname}"
        elsif defined?(params) && (params || {})[:controller].present?
          return [params[:controller].split("/").join("_"), params[:action]].compact.join("_")
        elsif defined?(request) && request.respond_to?(:path_info)
          ::File.basename(request.path_info).to_s
        end
        ""
      end
      
    end # Layout
    
  end # Helpers
end # Facades
