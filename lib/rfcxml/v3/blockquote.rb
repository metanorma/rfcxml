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
# require_relative "ol"
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
    class Ol < Lutaml::Model::Serializable; end
    class Dl < Lutaml::Model::Serializable; end

    class Blockquote < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :cite, :string
      attribute :quoted_from, :string
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
        root "blockquote"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "cite", to: :cite
        map_attribute "quotedFrom", to: :quoted_from
        map_element "artset", to: :artset
        map_element "artwork", to: :artwork
        map_element "dl", to: :dl
        map_element "figure", to: :figure
        map_element "ol", to: :ol
        map_element "sourcecode", to: :sourcecode
        map_element "t", to: :t
        map_element "ul", to: :ul
        map_element "bcp14", to: :bcp14
        map_element "br", to: :br
        map_element "cref", to: :cref
        map_element "em", to: :em
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "relref", to: :relref
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
        map_element "u", to: :u
        map_element "xref", to: :xref
      end
    end
  end
end
