require 'sass'

module Facades
  module SassExtensions    
  end
end

['color', 'conversions', 'functions'].each do |extension|
  require "facades/sass_extensions/#{extension}"
  Sass::Script::Functions.send(:include, Facades::SassExtensions.const_get(extension.camelize))
end

class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end