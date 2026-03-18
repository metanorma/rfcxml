# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Tbody < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :tr, Tr, collection: true

      xml do
        element "tbody"

        map_attribute "anchor", to: :anchor
        map_element "tr", to: :tr
      end
    end
  end
end
