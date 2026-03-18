# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Td < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :colspan, :string
      attribute :rowspan, :string
      attribute :align, :string,
                values: %w[left center right]
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :dl, Dl, collection: true
      attribute :figure, Figure, collection: true
      attribute :ol, Ol, collection: true
      attribute :sourcecode, Sourcecode, collection: true
      attribute :t, Text, collection: true
      attribute :ul, Ul, collection: true
      attribute :bcp14, Bcp14, collection: true
      attribute :br, Br, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :strong, Strong, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :u, U, collection: true
      attribute :xref, Xref, collection: true

      xml do
        element "td"
        mixed_content

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "colspan", to: :colspan
        map_attribute "rowspan", to: :rowspan
        map_attribute "align", to: :align

        %w[artset artwork dl figure ol sourcecode t ul bcp14 br cref em eref
           iref relref strong sub sup tt u xref].each do |element|
          map_element element, to: element.to_sym
        end
      end
    end
  end
end
