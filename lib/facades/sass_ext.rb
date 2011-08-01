require 'sass'

module Facades
  module SassExt
    autoload :FormElements, 'facades/sass_ext/form_elements'
  end
end

module Sass::Script::Functions
  include Facades::SassExt::FormElements
end

class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end