# frozen_string_literal: true

require "lutaml/model"

require_relative "tr"

module Rfcxml
  module V3
    class Thead < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :tr, Tr, collection: true

      xml do
        root "thead"

        map_attribute "anchor", to: :anchor
        map_element "tr", to: :tr
      end
    end
  end
end
