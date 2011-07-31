module FacadesHelper
  
  include Facades::Helpers::Layout
  include Facades::Helpers::Navigation
  
  def facade_assets
    content = if_ie(8) do
      javascript_include_tag("https://html5shim.googlecode.com/svn/trunk/html5.js")
    end
    content.to_s.html_safe
  end
  
  ##
  # Render an IE conditional statement. By default conditionals use a less-than-or-equal-to format. Use the `specific`
  # param to force only that version.
  # 
  # @param version [Integer] The IE version to target
  # @param specific [Boolean] optional Target the IE version specificially. 
  # 
  # 
  def if_ie(version, specific = false, &block)
    content = capture(&block)
    condition = specific ? "IE #{version}" : "lte IE #{version}"
    str = "<!--[if #{condition}]>"
  	str << content.html_safe.lstrip
  	str << "<![endif]-->"
  	str.html_safe
  end
    
end