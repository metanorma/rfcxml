# frozen_string_literal: true

require "lutaml/model"

require_relative "name"
require_relative "reference"
require_relative "referencegroup"

module Rfcxml
  module V3
    class References < Lutaml::Model::Serializable
      attribute :pn, :string
      attribute :anchor, :string
      attribute :title, :string
      attribute :name, Name
      attribute :references, References, collection: true
      attribute :reference, Reference, collection: true
      attribute :referencegroup, Referencegroup, collection: true

      xml do
        root "references"

        map_attribute "pn", to: :pn
        map_attribute "anchor", to: :anchor
        map_attribute "title", to: :title
        map_element "name", to: :name
        map_element "references", to: :references
        map_element "reference", to: :reference
        map_element "referencegroup", to: :referencegroup
      end
    end
  end
end
