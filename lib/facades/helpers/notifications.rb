module Facades
  module Helpers
    module Notifications
      
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
          closer ||= "<span class='close'>&times;</span>"
        end
        klasses = (attrs.delete(:class) || "").split(" ")
        klasses << "flash-message"  
        content = ""    

        flash.each do |key, value|
          next if value === true or value.to_s == 'true' # fix awkward devise message
          klasses << "notification"
          klasses << "flash-message-#{key.to_s.underscore}"
          msg_attrs = attrs.merge(:class => [key.to_s, klasses].flatten.join(' '))
          content.concat content_tag(wrapper, "#{value} #{closer}".html_safe, msg_attrs).html_safe
        end    

        content.html_safe    

      end
      
    end
  end
end