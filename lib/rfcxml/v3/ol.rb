# frozen_string_literal: true

require "lutaml/model"

require_relative "li"

module Rfcxml
  module V3
    class Ol < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :type, :string, default: -> { "1" }
      attribute :start, :string, default: -> { "1" }
      attribute :group, :string
      attribute :spacing, :string, default: -> { "normal" }
      attribute :indent, :string, default: -> { "adaptive" }
      attribute :pn, :string
      attribute :li, Li, collection: true

      xml do
        root "ol"

        map_attribute "anchor", to: :anchor
        map_attribute "type", to: :type
        map_attribute "start", to: :start
        map_attribute "group", to: :group
        map_attribute "spacing", to: :spacing
        map_attribute "indent", to: :indent
        map_attribute "pn", to: :pn
        map_element "li", to: :li
      end
    end
  end
end
