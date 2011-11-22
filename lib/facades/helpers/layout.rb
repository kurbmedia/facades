module Facades
  module Helpers
    ##
    # 
    # # Convenience helpers generally used in layout files
    # 
    module Layout
      
      ##
      # 
      # Allows easy assigning of meta tags from templates
      # @param [Symbol] name Name of the meta tag (ie: keywords / description)
      # @param [String] content The content to be used in the meta tag
      # @return [String] A html meta tag with the name and content attributes set
      # 
      def meta_tag(name, content = nil)
        return _retrieve_variable(:"__#{name}") if content.nil?
        content = tag(:meta, :name => name, :content => content)
        _create_variable(:"__#{name}", content, false)
        content
      end
      
      ##
      # Create a script tag for activating google analytics
      # @param [String] site_id The site ID provided by google analytics
      # @return [String] script tag
      # 
      def google_analytics(site_id, &block)
        return "" if defined?(Rails) && Rails.env != "production"        
        additional = capture(&block) if block_given?
        additional ||= ""
        content_tag(:script) do          
          %Q{
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', #{site_id}]);
            _gaq.push(['_trackPageview']);
            #{additional}
            (function() {
              var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
              ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
              var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
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
        _create_variable(:__page_id, content, false) and return if content
        return _retrieve_variable(:__page_id) if content_for?(:__page_id)
        result = if defined?(controller)
          cname = controller.class.to_s.gsub(/controller$/i,'').underscore.split("/").join('_')
          aname = controller.action_name          
          "#{cname}_#{aname}"
        elsif defined?(request) && request.respond_to?(:path_info)
          ::File.basename(request.path_info).to_s
        end
        result
      end
      
      ##
      # 
      # Convenienve method to create a page title for the <title></title> tag.
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
        _create_variable(:__page_title, content, false) and return if content
        return _retrieve_variable(:__page_title) if content_for?(:__page_title)
        return ""
      end
      
      ##
      # 
      # Convenience method for content_for allowing for single-line variable creation. Also defines a method that can be
      # re-used within a template.
      # 
      # @param [Symbol] var_name The name of the variable to create
      # @param [String] content The content that variable defines
      # @return [String] An empty string. Use the newly created method from +var_name+ to return the value
      # 
      # @example Setting a "page_class" variable
      #   <% set_var(:page_class, 'cool') %>
      #   <%= page_class %> #=> 'cool'
      #
      #  
      def set_var(var_name, content)
        _create_variable("#{var_name}", content) and return ''
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
      
      def _create_variable(var, content, create_method = true) #:nodoc:
        content_for(var.to_sym, content)
        return '' unless create_method
        class_eval <<-MAKE_VAR, __FILE__, __LINE__ + 1
          def #{var}
            content_for(:#{var})
          end
          public :#{var}
        MAKE_VAR
      end
            
      def _retrieve_variable(var) #:nodoc:
        (content_for?(var.to_sym) ? content_for(var.to_sym) : "")
      end
      
    end
    
    
  end
end