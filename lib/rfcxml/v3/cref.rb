# frozen_string_literal: true

require "lutaml/model"

require_relative "br"
require_relative "em"
require_relative "eref"
require_relative "relref"
require_relative "strong"
require_relative "sub"
require_relative "sup"
require_relative "tt"
require_relative "xref"

module Rfcxml
  module V3
    class Cref < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :source, :string
      attribute :display, :string, default: -> { "true" }
      attribute :br, Br, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :relref, Relref, collection: true
      attribute :strong, Strong, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "cref"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "source", to: :source
        map_attribute "display", to: :display
        map_element "br", to: :br
        map_element "em", to: :em
        map_element "eref", to: :eref
        map_element "relref", to: :relref
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
        map_element "xref", to: :xref
      end
    end
  end
end
