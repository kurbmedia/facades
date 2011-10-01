module Facades::Builders
  module FormHelper
    ##
    # 
    # Cusomizes the default form_for helper to add additional functionality
    # All params are the same as Rails' form_for
    # 
    # @param [Mixed] record_name_or_array
    # @param [Array] args 
    # @param [Block] &block
    # 
    def form_for(record_name_or_array, *args, &proc)
   
      raise ArgumentError, "Missing block" unless block_given?
    
      options = args.extract_options!
      options.reverse_merge!(:builder => Facades::Builders::Form)
      options[:html] ||= {}
      options[:html].merge!('data-js-validatable' => true) if options.delete(:validate)
    
      default_proc = ::ActionView::Base.field_error_proc
      ::ActionView::Base.field_error_proc = lambda{ |html_tag, instance_tag| html_tag }
      super(record_name_or_array, *(args << options), &proc)
      ensure
        ::ActionView::Base.field_error_proc = default_proc
    end
    
  end
end