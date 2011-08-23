module Facades
  module Helpers
    ##
    # Helper methods for mobile tags and attributes
    module Mobile
      
      def mobile_meta_tags
        [ tag(:meta, {"http-equiv" => 'cleartype', 'content' => 'on' }), # IE Cleartype
          meta_tag('HandheldFriendly', 'True'),
          meta_tag('viewport', "width=device-width, minimum-scale=1.0, initial-scale=1.0")
        ].join("\n")        
      end
      
    end
  end
end