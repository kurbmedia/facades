Sass::Tree::MixinDefNode

module Sass
  module Tree
    class MixinDefNode < Sass::Tree::Node
      def to_s
        Facades::Debug.available_mixins.merge!(name.to_s => args)
        super()
      end
    end
  end
end
