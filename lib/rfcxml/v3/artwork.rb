# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Artwork < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :name, :string, default: -> { "" }
      attribute :type, :string, default: -> { "" }
      attribute :src, :string
      attribute :align, :string, default: -> { "left" }
      attribute :alt, :string, default: -> { "" }
      attribute :width, :string, default: -> { "" }
      attribute :height, :string, default: -> { "" }
      attribute :original_src, :string

      xml do
        root "artwork"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "name", to: :name
        map_attribute "type", to: :type
        map_attribute "src", to: :src
        map_attribute "align", to: :align
        map_attribute "alt", to: :alt
        map_attribute "width", to: :width
        map_attribute "height", to: :height
        map_attribute "originalSrc", to: :original_src
      end
    end
  end
end
