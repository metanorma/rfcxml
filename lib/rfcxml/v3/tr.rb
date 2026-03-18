# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Tr < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :td, Td, collection: true
      attribute :th, Th, collection: true

      xml do
        element "tr"
        ordered
        mixed_content

        map_attribute "anchor", to: :anchor
        map_element "td", to: :td
        map_element "th", to: :th
      end
    end
  end
end
