# frozen_string_literal: true

require "lutaml/model"

require_relative "artset"
require_relative "artwork"
require_relative "bcp14"
require_relative "br"
require_relative "cref"
require_relative "dl"
require_relative "em"
require_relative "eref"
require_relative "figure"
require_relative "iref"
require_relative "ol"
require_relative "relref"
require_relative "sourcecode"
require_relative "strong"
require_relative "sub"
require_relative "sup"
require_relative "text"
require_relative "tt"
require_relative "u"
require_relative "ul"
require_relative "xref"

module Rfcxml
  module V3
    class Td < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :colspan, :string, default: -> { "1" }
      attribute :rowspan, :string, default: -> { "1" }
      attribute :align, :string, default: -> { "left" }
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :dl, Dl, collection: true
      attribute :figure, Figure, collection: true
      attribute :ol, Ol, collection: true
      attribute :sourcecode, Sourcecode, collection: true
      attribute :t, Text, collection: true
      attribute :ul, Ul, collection: true
      attribute :bcp14, Bcp14, collection: true
      attribute :br, Br, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :strong, Strong, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :u, U, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "td"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "colspan", to: :colspan
        map_attribute "rowspan", to: :rowspan
        map_attribute "align", to: :align

        %w[artset artwork dl figure ol sourcecode t ul bcp14 br cref em eref
           iref relref strong sub sup tt u xref].each do |element|
          map_element element, to: element.to_sym
        end
      end
    end
  end
end
