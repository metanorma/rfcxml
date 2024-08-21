# frozen_string_literal: true

require "lutaml/model"

require_relative "artset"
require_relative "artwork"
require_relative "iref"
require_relative "name"
require_relative "postamble"
require_relative "preamble"
require_relative "sourcecode"

module Rfcxml
  module V3
    class Figure < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :pn, :string
      attribute :title, :string, default: -> { "" }
      attribute :suppress_title, :string, default: -> { "false" }
      attribute :src, :string
      attribute :original_src, :string
      attribute :align, :string, default: -> { "left" }
      attribute :alt, :string, default: -> { "" }
      attribute :width, :string, default: -> { "" }
      attribute :height, :string, default: -> { "" }
      attribute :name, Name
      attribute :iref, Iref, collection: true
      attribute :preamble, Preamble
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :sourcecode, Sourcecode, collection: true
      attribute :postamble, Postamble

      xml do
        root "figure"

        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "title", to: :title
        map_attribute "suppress-title", to: :suppress_title
        map_attribute "src", to: :src
        map_attribute "originalSrc", to: :original_src
        map_attribute "align", to: :align
        map_attribute "alt", to: :alt
        map_attribute "width", to: :width
        map_attribute "height", to: :height
        map_element "name", to: :name
        map_element "iref", to: :iref
        map_element "preamble", to: :preamble
        map_element "artset", to: :artset
        map_element "artwork", to: :artwork
        map_element "sourcecode", to: :sourcecode
        map_element "postamble", to: :postamble
      end
    end
  end
end
