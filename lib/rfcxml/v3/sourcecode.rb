# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Sourcecode < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :name, :string, default: -> { "" }
      attribute :type, :string, default: -> { "" }
      attribute :markers, :string, default: -> { "false" }
      attribute :src, :string
      attribute :original_src, :string

      xml do
        root "sourcecode"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "markers", to: :markers
        map_attribute "src", to: :src
        map_attribute "originalSrc", to: :original_src
      end
    end
  end
end
