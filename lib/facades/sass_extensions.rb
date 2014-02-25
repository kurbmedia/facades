require 'sass'
require 'sass/tree/mixin_def_node'

module Facades
  module SassExtensions 
    extend self
    
    def vendor_prefixes
      [:webkit, :moz, :ms, :o]
    end   
    
  end
end

require 'facades/sass_extensions/debugging'

['color', 'conversions', 'functions', 'icons'].each do |extension|
  require "facades/sass_extensions/#{extension}"
  Sass::Script::Functions.send(:include, Facades::SassExtensions.const_get(extension.camelize))
end

class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end