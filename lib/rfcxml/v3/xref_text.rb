# frozen_string_literal: true

# require_relative "em"
# require_relative "strong"
# require_relative "sub"
# require_relative "sup"
# require_relative "tt"
require "lutaml/model"

module Rfcxml
  module V3
    class Strong < Lutaml::Model::Serializable; end
    class Em < Strong; end
    class Sub < Lutaml::Model::Serializable; end
    class Sup < Sub; end
    class Tt < Lutaml::Model::Serializable; end

    module XrefText
      def self.included(base)
        base.class_eval do
          attribute :em, ::Rfcxml::V3::Em, collection: true
          attribute :strong, V3::Strong, collection: true
          attribute :sub, V3::Sub, collection: true
          attribute :sup, V3::Sup, collection: true
          attribute :tt, V3::Tt, collection: true
        end
      end
    end
  end
end
