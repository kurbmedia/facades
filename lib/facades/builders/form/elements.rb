module Facades::Builders
  module FormBuilder
    module Elements
      extend ActiveSupport::Concern
      
      included do
        # create overrides for custom rendering
        [:email_field, :password_field, :text_field, :text_area, :url_field, :select].each do |method|      
          class_eval <<-FUNC, __FILE__, __LINE__ + 1
        
            alias :_super_#{method} :#{method}
      
            def #{method}(method_name, *args)
              render_field_as_custom(:#{method}, method_name, *args)
            end
          FUNC
        end
      end
      
      ##
      # Modified label tag to support adding a 'required' asterisk to the end of the label.
      # Same params as the original implementation
      # 
      def label(method, text = nil, options = {}, &block) #:nodoc:
        
        options, text = text, nil if text.is_a?(Hash)
        text ||= method.to_s.humanize
        
        options.stringify_keys!
        klasses = (options.delete(['class']) || "").split(" ")
        klasses << 'field-with-error' if errors_on_attribute?(method)
        options['class'] = klasses.join(" ") unless klasses.compact.empty?
        
        text = "#{text} <abbr title='Required'>*</abbr>".html_safe  if attribute_required?(method) || required_by_option?(options.delete('required'))        
        super(method, text, options, &block)
        
      end
      
      ##
      # 
      # Creates a button tag to be used in a form instead of the default input[type=submit]
      # to help make CSS styling easier
      # 
      # @param [String] value The text for the button
      # @param [Hash] options HTML options to be passed to the button
      # @option [String] icon If included, adds an image to the button to be used as an icon
      # 
      def button(value = nil, options = {})
        
        value, options = nil, value if value.is_a?(Hash)
        value ||= submit_default_value

        value    = [image_tag(icon, :class => 'icon'), value].join(' ') if icon = options.delete(:icon)
        klasses = (options.delete(:class) || "").split(" ")
        klasses << "button"
        options['class'] = klasses.join(" ")
        content_tag(:button, value.to_s.html_safe, options.reverse_merge!({ "type" => "submit", "name" => "commit" }))
        
      end
      
      ##
      # 
      # Generate a select tag with the 50 US states as options
      # 
      # @param [Symbol] method The object method/attribute to be used
      # @param [Hash] options Same as Rails' select options hash
      # @option options [Symbol] :international Include an international option
      # @option options [Symbol] :abbreviate Use an abbreviated version of the state name for the value
      # @param [Hash] html_options Same as Rails' html_options hash
      # 
      # @return [String] HTML select tag
      # 
      def state_select(method, options = {}, html_options = {})
        abbr = options.delete(:abbreviate)
        abbr = !(abbr.nil? || abbr === false)
        select(method, @template.options_for_select(options_for_state_select(abbr, options.delete(:international)), @object.try(:state)), options, html_options)        
      end
      
      protected
      
      ##
      # 
      # Returns a list of US states as an array
      # 
      # @param [Boolean] abbreviate Abbreviate the value
      # @param [Boolean, String] incl_international Include an additional state for "International"
      # 
      # @return [Array] An array of states
      # 
      def options_for_state_select(abbreviate = false, incl_international = false)
        incl_international ||= false
        state_list = [
            ['Alabama', "AL"],['Alaska', "AK"],['Arizona', "AZ"],['Arkansas', "AR"],['California', "CA"],['Colorado', "CO"],
          	['Connecticut', "CT"],['District of Columbia', "DC"],['Delaware', "DE"],['Florida', "FL"],['Georgia', "GA"],
          	['Hawaii', "HI"],['Idaho', "ID"],['Illinois', "IL"],['Indiana', "IN"],['Iowa', "IA"],['Kansas', "KS"],['Kentucky', "KY"],
          	['Louisiana', "LA"],['Maine', "ME"],['Maryland', "MD"],['Massachusetts', "MA"],['Michigan', "MI"],['Minnesota', "MN"],
          	['Mississippi', "MS"],['Missouri', "MO"],['Montana', "MT"],['Nebraska', "NE"],['Nevada', "NV"],['New Hampshire', "NH"],
          	['New Jersey', "NJ"],['New Mexico', "NM"],['New York', "NY"],['North Carolina', "NC"],['North Dakota', "ND"],
          	['Ohio', "OH"],['Oklahoma', "OK"],['Oregon', "OR"],['Pennsylvania', "PA"],['Rhode Island', "RI"],['South Carolina', "SC"],
          	['South Dakota', "SD"],['Tennessee', "TN"],['Texas', "TX"],['Utah', "UT"],['Vermont', "VT"],['Virginia', "VA"],['Washington', "WA"],
          	['West Virginia', "WV"],['Wisconsin', "WI"],['Wyoming', "WY"]
          	
        ].map do |state|
          (abbreviate ? state : [state.first, state.first])
        end
        state_list << ['International', incl_international] unless incl_international === false
        state_list
      end
      
    end
  end
end