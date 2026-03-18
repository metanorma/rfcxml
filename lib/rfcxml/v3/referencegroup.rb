# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Referencegroup < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :derived_anchor, :string
      attribute :target, :string
      attribute :reference, Reference, collection: true

      xml do
        element "referencegroup"
        ordered

        map_attribute "anchor", to: :anchor
        map_attribute "derivedAnchor", to: :derived_anchor
        map_attribute "target", to: :target
        map_element "reference", to: :reference
      end
    end
  end
end
