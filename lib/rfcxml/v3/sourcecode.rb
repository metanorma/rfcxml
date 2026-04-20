# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Sourcecode < Lutaml::Model::Serializable
      attribute :content, :string, collection: true
      attribute :anchor, :string
      attribute :pn, :string
      attribute :name, :string
      attribute :type, :string
      attribute :markers, :string
      attribute :src, :string
      attribute :original_src, :string

      xml do
        element "sourcecode"
        mixed_content

        map_content to: :content
        map_attribute "anchor", to: :anchor,
                                value_map: { to: { empty: :empty } }
        map_attribute "pn", to: :pn, value_map: { to: { empty: :empty } }
        map_attribute "name", to: :name, value_map: { to: { empty: :empty } }
        map_attribute "type", to: :type, value_map: { to: { empty: :empty } }
        map_attribute "markers", to: :markers,
                                 value_map: { to: { empty: :empty } }
        map_attribute "src", to: :src, value_map: { to: { empty: :empty } }
        map_attribute "originalSrc", to: :original_src,
                                     value_map: { to: { empty: :empty } }
      end
    end
  end
end
