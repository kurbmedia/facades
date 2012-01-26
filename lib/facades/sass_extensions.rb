require 'sass'

module Facades
  module SassExtensions 
    extend self
    
    def vendor_prefixes
      [:webkit, :moz, :ms, :o]
    end   
    
  end
end

['color', 'conversions', 'functions', 'icons'].each do |extension|
  require "facades/sass_extensions/#{extension}"
  Sass::Script::Functions.send(:include, Facades::SassExtensions.const_get(extension.camelize))
end

class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end