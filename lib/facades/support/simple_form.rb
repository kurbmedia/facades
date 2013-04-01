require 'simple_form/version'

if SimpleForm::VERSION.to_i >= 2
  SimpleForm.setup do |config|
  
    config.label_text = lambda { |label, required| "#{label} #{required}" }
    config.required_by_default = false
    config.country_priority = 'United States'
    config.default_input_size = 30
  
    config.wrappers :facades, tag: :li, class: 'field', error_class: 'invalid-field' do |b|
      b.use :html5
      b.use :placeholder
    
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
        
      b.use :label_input, wrap_with: { error_class: 'invalid', tag: false }
      b.use :hint,        wrap_with: { tag: :span, class: :hint }
      b.use :error,       wrap_with: { tag: :span, class: :error }
    end
    
    config.html5 = true
    config.error_method = :first
    config.error_notification_id  = nil
    config.browser_validations    = false
    config.collection_wrapper_tag = nil 
    
  end 
end

