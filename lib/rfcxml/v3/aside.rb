# frozen_string_literal: true

require "lutaml/model"

require_relative "artset"
require_relative "artwork"
require_relative "blockquote"
require_relative "dl"
require_relative "figure"
require_relative "iref"
require_relative "ol"
require_relative "text"
require_relative "table"
require_relative "ul"

module Rfcxml
  module V3
    class Aside < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :pn, :string
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :blockquote, Blockquote, collection: true
      attribute :dl, Dl, collection: true
      attribute :figure, Figure, collection: true
      attribute :iref, Iref, collection: true
      attribute :ol, Ol, collection: true
      attribute :t, Text, collection: true
      attribute :table, Table, collection: true
      attribute :ul, Ul, collection: true

      xml do
        root "aside"

        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_element "artset", to: :artset
        map_element "artwork", to: :artwork
        map_element "blockquote", to: :blockquote
        map_element "dl", to: :dl
        map_element "figure", to: :figure
        map_element "iref", to: :iref
        map_element "ol", to: :ol
        map_element "t", to: :t
        map_element "table", to: :table
        map_element "ul", to: :ul
      end
    end
  end
end
