module Facades
  module Helpers
    ##
    # 
    # Generates misc html elements that aren't included in Rails core, or are custom.
    #
    module Elements
      
      ##
      # Generates a "button" link tag. Simply a convenience method to skip adding 'class="button"' and also adds an +icon+ option
      # @see Motr::Forms::Builder#button For form related buttons
      # 
      # @param [String] txt The link text
      # @param [String] path The link href
      # @param [Types] Name Description
      # 
      # @example Create a plain link.button 
      #   button_link('Blog', '/blog') #=> <a href="/blog" class="button">Blog</a>
      # @example Create a link.button with icon
      #   button_link('Blog', '/blog', :icon => 'blog_image.png') #=> <a href="/blog" class="button"><img src="/images/blog_image.png" alt="Blog" /> Blog</a>

      def button_link(txt, path, attrs = {}, incl_span = false)
        image   = attrs.delete(:icon)
        klasses = (attrs.delete(:class) || "").split(" ")
        klasses << 'button'
        klasses  = klasses.uniq.compact        
        content  = ""
        content <<  image_tag(image) unless image.nil?
        content << (incl_span ? "<span>#{txt}</span>" : txt)
        link_to content.html_safe, path, attrs.merge(:class => klasses.join(" "))
      end
      
      ##
      # 
      # Convenience method for outputting all current flash messages. This allows you to avoid 
      # using things like "if flash[:success]" and so on, which is far from DRY
      # 
      # @param [Hash] attrs Options to modify the html attributes and settings
      # @option attrs [Symbol] closer Specify HTML to be appended to the message in case you want a "close" button/link. Defaults to "<span>X</span>"
      # @option attrs [Symbol] wrapper Specify the HTML element which wraps each message. Defaults to :div
      # 
      # @example Output any available flash messages, appending a "closer" span
      #   In your controller:
      #     flash[:success] = "You did something awesome"
      #   In your view or layout
      #   <%= flash_messages :close => "<span>X</span>" %> #=> <div class="flash_message flash_message_success success">You did something awesome <span>X</span></div>
      # 
      # @example Output a message without a "close"
      #   <%= flash_messages :close => false %> #=> <div class="flash_message flash_message_success success">You did something awesome</div>
      #
      #
      def flash_messages(attrs = {})
        
        return if flash.nil? or flash.empty?
        
        wrapper = attrs.delete(:wrapper) || :div
        closer  = attrs.delete(:closer)
        unless closer === false
          closer ||= "<span>X</span>"
        end
        klasses = (attrs.delete(:class) || "").split(" ")
        klasses << "flash_message"  
        content = ""    
        
        flash.each do |key, value|
          klasses << "flash_message_#{key.to_s.underscore}"
          msg_attrs = attrs.merge(:class => [key.to_s, klasses].flatten.join(' '))
          content.concat content_tag(wrapper, "#{value} #{closer}".html_safe, msg_attrs).html_safe
        end    
        
        content.html_safe    
        
      end
      
    end
    
  end
end