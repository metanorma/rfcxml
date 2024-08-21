# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Li < Lutaml::Model::Serializable; end

    class Ul < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :spacing, :string, default: -> { "normal" }
      attribute :empty, :string, default: -> { "false" }
      attribute :bare, :string, default: -> { "false" }
      attribute :indent, :string, default: -> { "3" }
      attribute :pn, :string
      attribute :li, Li, collection: true

      xml do
        root "ul"

        map_attribute "anchor", to: :anchor
        map_attribute "spacing", to: :spacing
        map_attribute "empty", to: :empty
        map_attribute "bare", to: :bare
        map_attribute "indent", to: :indent
        map_attribute "pn", to: :pn
        map_element "li", to: :li
      end
    end
  end
end
