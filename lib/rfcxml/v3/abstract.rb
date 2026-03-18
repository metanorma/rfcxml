# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Abstract < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :pn, :string
      attribute :dl, Dl, collection: true
      attribute :ol, Ol, collection: true
      attribute :t, Text, collection: true
      attribute :ul, Ul, collection: true

      xml do
        element "abstract"
        ordered

        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_element "dl", to: :dl
        map_element "ol", to: :ol
        map_element "t", to: :t
        map_element "ul", to: :ul
      end
    end
  end
end
