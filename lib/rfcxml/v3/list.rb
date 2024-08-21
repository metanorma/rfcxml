# frozen_string_literal: true

require "lutaml/model"

require_relative "text"

module Rfcxml
  module V3
    class List < Lutaml::Model::Serializable
      attribute :style, :string, default: -> { "empty" }
      attribute :hang_indent, :string
      attribute :counter, :string
      attribute :pn, :string
      attribute :text, Text, collection: true

      xml do
        root "list"

        map_attribute "style", to: :style
        map_attribute "hangIndent", to: :hang_indent
        map_attribute "counter", to: :counter
        map_attribute "pn", to: :pn
        map_element "t", to: :text
      end
    end
  end
end
