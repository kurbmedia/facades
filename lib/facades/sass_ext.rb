require 'sass'
module Facades
  module SassExt
  end
end

['form_elements', 'color', 'funcs'].each do |req|
  require "facades/sass_ext/#{req}"
  Sass::Script::Functions.send(:include, Facades::SassExt.const_get(req.camelize))
end

class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end