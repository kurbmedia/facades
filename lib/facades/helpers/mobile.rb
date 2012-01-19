module Facades
  module Helpers
    ##
    # Helper methods for mobile tags and attributes
    module Mobile
      
      def mobile_meta_tags
        tags = [ tag(:meta, {"http-equiv" => 'cleartype', 'content' => 'on' }), # IE Cleartype
          meta_tag('HandheldFriendly', 'True'),
          meta_tag('viewport', "width=device-width, minimum-scale=1.0, initial-scale=1.0")
        ].join("\n")        
        tags = tags.html_safe if tags.respond_to?(:html_safe)
      end
      
      def mobile_only(&block)
        return "" unless mobile_device?
        capture(&block)
      end
      
      def unless_mobile_device(&block)
        return "" if mobile_device?
        capture(&block)
      end
      
    end
    
    module MobileController
      extend ActiveSupport::Concern

      included do
        helper_method :mobile_device?, :iphone?, :android?
      end
      
      def mobile_device_user_agent_regexp
        Regexp.new(['palm','blackberry','nokia','phone','midp','mobi','symbian','chtml','ericsson','minimo',
         'audiovox','motorola','samsung','telit','upg1','windows ce','ucweb','astel','plucker',
         'x320','x240','j2me','sgh','portable','sprint','docomo','kddi','softbank','android','mmp',
         'pdxgw','netfront','xiino','vodafone','portalmmm','sagem','mot-','sie-','ipod','up\\.b',
         'webos','amoi','novarra','cdm','alcatel','pocket','ipad','iphone','mobileexplorer','mobile'].join('|'))
      end
      
      def iphone?
        request.user_agent.to_s.downcase.include?("iphone")
      end
      
      def android?
        request.user_agent.to_s.downcase.include?("android")
      end
      
      def mobile_device?
        request.user_agent.to_s.downcase =~ mobile_device_user_agent_regexp
      end
      
    end
    
  end
end