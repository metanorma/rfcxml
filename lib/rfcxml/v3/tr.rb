# frozen_string_literal: true

require "lutaml/model"

require_relative "td"
require_relative "th"

module Rfcxml
  module V3
    class Tr < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :td, Td, collection: true
      attribute :th, Th, collection: true

      xml do
        root "tr"

        map_attribute "anchor", to: :anchor
        map_element "td", to: :td
        map_element "th", to: :th
      end
    end
  end
end
