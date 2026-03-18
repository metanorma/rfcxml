# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Artwork < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :name, :string
      attribute :type, :string
      attribute :src, :string
      attribute :align, :string, values: %w[left center right]
      attribute :alt, :string
      attribute :width, :string
      attribute :height, :string
      attribute :original_src, :string

      xml do
        element "artwork"

        # Use map_all to capture both text content AND child elements like <svg>
        # map_content only captures text nodes, not child elements
        map_all to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "name", to: :name, value_map: { to: { empty: :empty } }
        map_attribute "type", to: :type, value_map: { to: { empty: :empty } }
        map_attribute "src", to: :src
        map_attribute "align", to: :align
        map_attribute "alt", to: :alt, value_map: { to: { empty: :empty } }
        map_attribute "width", to: :width, value_map: { to: { empty: :empty } }
        map_attribute "height", to: :height,
                                value_map: { to: { empty: :empty } }
        map_attribute "originalSrc", to: :original_src
      end
    end
  end
end
